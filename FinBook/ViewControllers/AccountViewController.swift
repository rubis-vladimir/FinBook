//
//  ViewController.swift
//  FinBook
//
//  Created by Владимир Рубис   on 11.07.2021.
//

import UIKit

protocol NewTransactionViewControllerDelegate {
    func saveTransaction(_ newTransaction: Transact)
}

protocol ThemeChange {
    func changeTheme(answer: Bool)
}

class AccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: - Properties
    private var transactions = StorageManager.shared.fetchData() // загрузка транзакций
    private var editTransIndexPath: IndexPath? = nil
    private var filteredTransactions: [Transact] = []
    private var timer: Timer?
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Override func viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupElements()
        setupSearchBar()
//        getData()
        reloadWalletBalance()
        reloadTransactArrayToFiltered()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ColorManager.shared.setThemeColors(mainElement: self.view, secondaryElement: self.navigationController?.navigationBar)
    }
    
    
    // MARK: - Private func
    
//    //  Загрузка данных из CoreData
//    private func getData() {
//        self.transactions = StorageManager.shared.fetchData()
//    }
    
    private func setupElements() {
        button.customizeButton(cradius: button.frame.width / 2, bgc: true)
        transactionTableView.backgroundColor = UIColor.clear
//        transactionTableView.allowsSelection = false // запрет на выделение строки
    }
    
    // расчет и вывод баланса кошелька по транзакциям
    private func reloadWalletBalance() {
//        self.transactions = transactions.sorted{ $0.date! < $1.date! }
        var currentBalance = 0.00
        for transaction in transactions {
            if transaction.incomeTransaction {
                currentBalance += transaction.cost
            } else { currentBalance -= transaction.cost}
        }
        balanceLabel.text = "\(currentBalance) "
    }
    
    private func reloadTransactArrayToFiltered() {
        self.transactions = sortedByDateTransactArray(array: transactions)
        self.filteredTransactions = sortedByDateTransactArray(array: filteredTransactions)
    }
    
    private func reloadDataTableView() {
        DispatchQueue.main.async {
            self.transactionTableView.reloadData()  // обновление  списка в основном потоке
        }
    }
    
    // Setup the search controller
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func transactionToDisplayAt(indexPath: IndexPath) -> Transact {
            let transaction: Transact
        //        Тернарный оператор
        //        "transaction" равно "filteredTransactions[indexPath.row]" если "isFiltering = true"
        //        иначе "transactions[indexPath.row]"
                transaction = isFiltering ? filteredTransactions[indexPath.row] : transactions[indexPath.row]
                    return transaction
        }
    
    //функция сортировки массивов по дате
    private func sortedByDateTransactArray(array: [Transact]) -> [Transact] {
        let transactArray = array.sorted { numLeft, numRight in
            guard let left = numLeft.date else { return true }
            guard let right = numRight.date else { return false }
            return left > right
        }
        return transactArray
        }
    
// MARK: - Navigation - переход и передача данных на TransactionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let transactionVC = segue.destination as? TransactionViewController else { return }
        
        if segue.identifier == "editTransaction" {
            transactionVC.editTransaction = sender as? Transact
        }

        transactionVC.delegate = self // обязательно для передачи транзакции !!!
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {    }
}

// MARK: - Table View Data Source & Delegate
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering { return filteredTransactions.count }
        return transactions.isEmpty ? 0 : transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! CustomTableViewCell
        
        let transaction = transactionToDisplayAt(indexPath: indexPath)

        return CustomTableViewCell.createCustomCell(cell, transaction)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
 
        let transaction = transactionToDisplayAt(indexPath: indexPath)
        
        let swipeEdit = UIContextualAction(style: .normal, title: "Редактировать") { (action, editView, success) in
            self.editTransIndexPath = indexPath
            self.performSegue(withIdentifier: "editTransaction", sender: transaction)
        }
        swipeEdit.image = UIImage(systemName: "square.and.pencil")
        
        let  swipeDelete = UIContextualAction(style: .destructive, title: "Удалить") { (action, delView, success) in
            self.transactions.remove(at: indexPath.row)
            StorageManager.shared.deleteTransaction(transaction)
            self.transactionTableView.deleteRows(at: [indexPath], with: .automatic)
            self.reloadWalletBalance()
        }
        swipeDelete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [swipeDelete, swipeEdit])  // "Редак-ть" и "Удалить" по свайпу
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 50 }

}

// MARK: - NewTransactionViewControllerDelegate
extension AccountViewController: NewTransactionViewControllerDelegate {
    func saveTransaction(_ newTransaction: Transact) {

        if let selectedIndexPath = editTransIndexPath?.row {          // -------------редактирование существующей транзакции
            
            transactionTableView.deselectRow(at:editTransIndexPath!, animated: true) // убираем выделение с ред. ячейки
            let edittingTransaction = transactionToDisplayAt(indexPath: editTransIndexPath!)
            
            StorageManager.shared.deleteTransaction(edittingTransaction) // удаляем старую версию транзакции
            
            if isFiltering {                             // если редактировали транз-ю в отфильтрованном списке
                filteredTransactions[selectedIndexPath] = newTransaction
                
                for (index,transaction) in transactions.enumerated() {
                    if transaction == edittingTransaction {
                        transactions[index] = newTransaction
                    }
                    self.editTransIndexPath = nil
                }
            } else {
                transactions[selectedIndexPath] = newTransaction
            }

            
        } else {        //  --------------Если добавляется новая транзакция
            
            self.transactions.append(newTransaction)                // передача и добавление новой трансакции в массив транзакций
            self.transactionTableView.insertRows(           // отображение на экране
                at: [IndexPath(row: self.transactions.count - 1, section: 0)],
                with: .automatic
            )
        }
        reloadTransactArrayToFiltered()
        reloadDataTableView()
        reloadWalletBalance()
    }
}

// MARK: - SearchBarDelegate
extension AccountViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.filteredTransactions = self.transactions.filter{ (transaction) -> Bool in
                
                
                return (transaction.category?.lowercased().contains(searchText.lowercased()))! || (transaction.descr?.lowercased().contains(searchText.lowercased()))!
            }
            DispatchQueue.main.async { self.transactionTableView.reloadData() }
        })
    }
}

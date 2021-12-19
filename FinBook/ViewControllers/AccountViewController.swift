//
//  ViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import UIKit

protocol NewTransactionViewControllerDelegate {
    func saveTransaction(cost: Double, description: String, category: String,date: Date, note: String, income: Bool)
}

class AccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: - Properties
    
    private var transactions: [Transact] = []
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
        
        setupSearchBar()
        getData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { self.transactionTableView.reloadData() }

    }
    
    
    // MARK: - Private func
    
    //  Загрузка данных из CoreData
    private func getData() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let transactions):
                self.transactions = transactions.sorted { $0.date! < $1.date! }
                reloadWalletBalance()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // расчет и вывод баланса кошелька по транзакциям
    private func reloadWalletBalance() {
        var currentBalance = 0.00
        for transaction in transactions {
            if transaction.incomeTransaction {
                currentBalance += transaction.cost
            } else { currentBalance -= transaction.cost}
        }
        balanceLabel.text = "\(currentBalance) "
    }
    
    // Setup the search controller
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
// MARK: - Navigation - переход и передача данных на TransactionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTransaction" {
            guard let transactionVC = segue.destination as? TransactionViewController else { return }
            transactionVC.delegate = self // обязательно для передачи транзакции !!!
        }
        
        if segue.identifier == "editTransaction" {
            guard let transactionVC = segue.destination as? TransactionViewController else { return }
            transactionVC.editTransaction = sender as? Transact
            transactionVC.delegate = self // обязательно для передачи транзакции !!!
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        transactionTableView.deselectRow(at:editTransIndexPath!, animated: true)
        self.editTransIndexPath = nil
    }
}

// MARK: - Table View Data Source
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering { return filteredTransactions.count }
        return transactions.isEmpty ? 0 : transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! CustomTableViewCell
        var transaction: Transact
        
        // Тернарный оператор
        // "transaction" равно "filteredTransactions[indexPath.row]" если "isFiltering = true" иначе "transactions[indexPath.row]"
        transaction = isFiltering ? filteredTransactions[indexPath.row] : transactions[indexPath.row]
        
        cell.categoryLabel.text = transaction.note
        cell.descriptionLabel.text = transaction.descr
        cell.costLabel.text = String(transaction.cost)
        cell.categoryLabel.text = transaction.category
        for (category, value) in CategoryService.categoryList {
            if category.rawValue == transaction.category {
                cell.categoryImage.image = value.1
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let transaction = transactions[indexPath.row]
        
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
    
    //  Передвижение транакций
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let itemToMove = transactions[sourceIndexPath.row]
//        transactions.remove(at: sourceIndexPath.row)
//        transactions.insert(itemToMove, at: destinationIndexPath.row)
//        walletBalance()
//    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 50 }

}

// MARK: - NewTransactionViewControllerDelegate
extension AccountViewController: NewTransactionViewControllerDelegate {
    func saveTransaction(cost: Double, description: String, category: String,
                         date: Date, note: String, income: Bool) {

        if let selectedIndexPath = editTransIndexPath?.row {
            StorageManager.shared.editData(transactions[selectedIndexPath],
                                           cost: cost, description: description,
                                           category: category, date: date,
                                           note: note, income: income)
  
            transactions[selectedIndexPath].cost = cost
            transactions[selectedIndexPath].descr = description
            transactions[selectedIndexPath].category = category
            transactions[selectedIndexPath].date = date
            transactions[selectedIndexPath].note = note
            transactions[selectedIndexPath].incomeTransaction = income
            transactionTableView.deselectRow(at:editTransIndexPath!, animated: true)
            self.editTransIndexPath = nil
            DispatchQueue.main.async { self.transactionTableView.reloadData() }
        } else {
            StorageManager.shared.saveData(cost: cost, description: description,
                                           category: category, date: date,
                                           note: note, income: income) { transaction in
                transactions.append(transaction)  // передача и добавление новой трансакции в массив транзакций
                self.transactionTableView.insertRows(   // отображение на экране
                    at: [IndexPath(row: self.transactions.count - 1, section: 0)],
                    with: .automatic
                )
            }
        }
        reloadWalletBalance()
    }
}

// MARK: - SearchBarDelegate
extension AccountViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.filteredTransactions = self.transactions.filter{
                $0.category?.contains(searchText) ?? false || $0.descr?.contains(searchText) ?? false
            }
            DispatchQueue.main.async { self.transactionTableView.reloadData() }  // обновление  списка в основном потоке
        })
    }
}


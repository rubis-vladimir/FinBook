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
// MARK: VC для вывода актуальных транзакций
class AccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: - Properties
    private var transactions = StorageManager.shared.fetchData() // загрузка транзакций
    private var editTransIndexPath: IndexPath? = nil
    private var filteredTransactions: [Transact] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var timer: Timer?
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
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
        reloadWalletBalance()
        sortedByDateAllTransactArrays()
    }
    
    // MARK: - Private func
    /// Установка размера кнопки `_` и стартового цвета фона TableView
    private func setupElements() {
        addButton.customizeButton(cradius: addButton.frame.width / 2)
        transactionTableView.backgroundColor = UIColor.clear
        view.backgroundColor = Palette.background
    }
    
    /// Расчет и вывод баланса кошелька по текущим транзакциям
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
    /// Сортировка основного массива `transactions` и отфильтрованого `filteredTransactions` по дате
    private func sortedByDateAllTransactArrays() {
        self.transactions = sortedByDateTransactArray(array: transactions)
        self.filteredTransactions = sortedByDateTransactArray(array: filteredTransactions)
    }
    /// Перезагрузка/обновление транзакций отображающихся в TableView параллельно в основном потоке
    private func reloadDataTableView() {
        DispatchQueue.main.async {
            self.transactionTableView.reloadData()
        }
    }
    /// Стартовые настройки `search controller`
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    /// Функция возврата списка транзакций в зависимости отфильтрованы транзакции в `search controller` или нет
    private func transactionToDisplayAt(indexPath: IndexPath) -> Transact {
        return isFiltering ? filteredTransactions[indexPath.row] : transactions[indexPath.row]
    }
    /// Функция сортировки массива `[Transact]` по дате
    private func sortedByDateTransactArray(array: [Transact]) -> [Transact] {
        let transactArray = array.sorted { numLeft, numRight in
            guard let left = numLeft.date else { return true }
            guard let right = numRight.date else { return false }
            return left > right
        }
        return transactArray
    } 
    // MARK: - Navigation
    /// переход и передача данных (редактируемой транзакции) на TransactionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let transactionVC = segue.destination as? TransactionViewController else { return }
        
        if segue.identifier == "editTransaction" {
            transactionVC.editTransaction = sender as? Transact
        }
        transactionVC.delegate = self /// обязательно для передачи транзакции !!!
    }
    /// Для возврата к данному VC
    @IBAction func unwind(segue: UIStoryboardSegue) {    }
}

// MARK: - Table View Data Source & Delegate
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    /// Указываем количество строк в секции tableView в зависимости отфильтрованы транзакции или нет
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering { return filteredTransactions.count }
        return transactions.isEmpty ? 0 : transactions.count
    }
    /// Заполняем строки tableView в зависимости отфильтрованы транзакции или нет
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! CustomTableViewCell
        let transaction = transactionToDisplayAt(indexPath: indexPath)
        return CustomTableViewCell.createCustomCell(cell, transaction)
    }
    /// Добавляем кнопки действий по свайпу справа на лево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        /// Вытаскиваем выбраную транзакцию
        let transaction = transactionToDisplayAt(indexPath: indexPath)
        /// При редактировании делаем переход на TransactionVC и передаем выбраную транзакцию
        let swipeEdit = UIContextualAction(style: .normal, title: "Редактировать") { (action, editView, success) in
            self.editTransIndexPath = indexPath
            self.performSegue(withIdentifier: "editTransaction", sender: transaction)
        }
        swipeEdit.image = UIImage(systemName: "square.and.pencil")
        /// При выборе "Удалить" удаляем из массива TableView и из памяти StorageManager и перезагружаем баланс кошелька
        let  swipeDelete = UIContextualAction(style: .destructive, title: "Удалить") { (action, delView, success) in
            self.transactions.remove(at: indexPath.row)
            StorageManager.shared.deleteTransaction(transaction)
            self.transactionTableView.deleteRows(at: [indexPath], with: .automatic)
            self.reloadWalletBalance()
        }
        swipeDelete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [swipeDelete, swipeEdit])  /// "Редак-ть" и "Удалить" по свайпу
    }
    ///Устанавливаем высоту ячейки tableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 60 }
}


// MARK: - NewTransactionViewControllerDelegate
extension AccountViewController: NewTransactionViewControllerDelegate {
    /// Функция вызывается из TransactionVC через делегата для внесения новой транзакции
    func saveTransaction(_ newTransaction: Transact) {
        /// Проверяем редактировали ли мы транзакцию или пришла новая
        if let selectedIndexPath = editTransIndexPath?.row {
            /// редактирование существующей транзакции
            /// убираем выделение с ред. ячейки
            transactionTableView.deselectRow(at:editTransIndexPath!, animated: true)
            let edittingTransaction = transactionToDisplayAt(indexPath: editTransIndexPath!)
            /// удаляем старую версию транзакции
            StorageManager.shared.deleteTransaction(edittingTransaction)
            /// если редактировали транз-ю в отфильтрованном списке
            if isFiltering {
                /// находим старую версию транзакции в отфильтрованом списке
                filteredTransactions[selectedIndexPath] = newTransaction
                
                for (index,transaction) in transactions.enumerated() {
                    if transaction == edittingTransaction {
                        transactions[index] = newTransaction
                    }
                    /// Обнуляем IndexPath редактируемой строки
                    self.editTransIndexPath = nil
                }
            } else {
                transactions[selectedIndexPath] = newTransaction
            }
            
        } else { /// Если нас пришла НОВАЯ (а не редактируемая) транзакция
            
            /// Добавляем новую трансакцию в массив транзакций
            self.transactions.append(newTransaction)
            self.transactionTableView.insertRows(           /// отображение на экране в TableView
                at: [IndexPath(row: self.transactions.count - 1, section: 0)],
                with: .automatic
            )
        }
        ///сортировка основного массива `transactions` и отфильтрованого `filteredTransactions` по дате
        sortedByDateAllTransactArrays()
        /// Перезагрузка/обновление транзакций отображающихся в TableView параллельно в основном потоке
        reloadDataTableView()
        /// Расчет и вывод баланса кошелька по текущим транзакциям
        reloadWalletBalance()
    }
}


// MARK: - SearchBarDelegate
extension AccountViewController: UISearchBarDelegate {
    /// Настройка SearchBar, установка критериев фильтрования списка транзакций
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.filteredTransactions = self.transactions.filter{ (transaction) -> Bool in
                
                return (transaction.category?.lowercased().contains(searchText.lowercased()))! || (transaction.descr?.lowercased().contains(searchText.lowercased()))!
            }
            self.reloadDataTableView()
        })
    }
}

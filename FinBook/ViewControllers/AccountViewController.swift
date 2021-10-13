//
//  ViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import UIKit

protocol NewTransactionViewControllerDelegate {
    func saveTransaction(_ transaction: Transaction)
}

class AccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var transactionTableView: UITableView!
    
    // MARK: - Properties
    
    private var transactions: [Transaction] = []
    private var filteredTransactions: [Transaction] = []
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
        transactions = StorageManager.shared.fetchTransactions()
    }
    
    // MARK: - Private func
    
    // Setup the search controller
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTransaction" {
            let transactionVC = segue.destination as! TransactionViewController
            transactionVC.delegate = self // обязательно для передачи транзакции !!!
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - IBActions
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if transactionTableView.isEditing {
            transactionTableView.setEditing(false, animated: true)
            sender.image = UIImage(systemName: "rectangle.stack")
        } else {
            transactionTableView.setEditing(true, animated: true)
            sender.image = UIImage(systemName: "checkmark")
        }
    }
}

// MARK: - Table View Data Source
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredTransactions.count
        }
        return transactions.isEmpty ? 0 : transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! CustomTableViewCell
        
        var transaction: Transaction
        
        if isFiltering {
            transaction = filteredTransactions[indexPath.row]
        } else {
            transaction = transactions[indexPath.row]
        }
        
        cell.categoryLabel.text = transaction.note
        cell.descriptionLabel.text = transaction.description
        cell.costLabel.text = String(transaction.cost)
        cell.categoryLabel.text = transaction.category.rawValue
        for (category, value) in CategoryService.categoryList {
            if category == transaction.category {
                cell.categoryImage.image = value.1
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            transactions.remove(at: indexPath.row)
            StorageManager.shared.deleteTransaction(at: indexPath.row)
            transactionTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = transactions[sourceIndexPath.row]
        transactions.remove(at: sourceIndexPath.row)
        transactions.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

// MARK: - NewTransactionViewControllerDelegate
extension AccountViewController: NewTransactionViewControllerDelegate {
    func saveTransaction(_ transaction: Transaction) {
        transactions.append(transaction)  ////передача и добавление новой трансакции в массив
        transactionTableView.reloadData()
    }
}

// MARK: - SearchBarDelegate
extension AccountViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            self.filteredTransactions = self.transactions.filter{ $0.category.rawValue.contains(searchText) || $0.description.contains(searchText)
            }
            self.transactionTableView.reloadData()
        })
    }
}


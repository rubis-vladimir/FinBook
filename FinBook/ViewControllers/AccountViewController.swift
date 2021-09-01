//
//  ViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import UIKit

class AccountViewController: UIViewController {

    var transactionList = Transaction.getTransactionList()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var transactionTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if transactionTableView.isEditing {
            transactionTableView.setEditing(false, animated: true)
            sender.image = UIImage(systemName: "rectangle.stack")
        } else {
            transactionTableView.setEditing(true, animated: true)
            sender.image = UIImage(systemName: "checkmark")
        }
    }
    
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! CustomTableViewCell
        
        cell.categoryLabel.text = transactionList[indexPath.row].note
        cell.descriptionLabel.text = transactionList[indexPath.row].description
        cell.costLabel.text = String(transactionList[indexPath.row].cost)
        
        for (category, value) in CategoryService.categoryList {
            if category == transactionList[indexPath.row].category {
                cell.categoryImage.image = value.1
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            transactionList.remove(at: indexPath.row)
            transactionTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = transactionList[sourceIndexPath.row]
        transactionList.remove(at: sourceIndexPath.row)
        transactionList.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}


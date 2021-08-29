//
//  ViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 11.07.2021.
//

import UIKit

class AccountViewController: UIViewController {

    var firstTransaction = [Transaction(cost: 100.0, label: "Покупка Хлеба", category: Category.products, date: Date(), note: "Заметка", incomeTransaction: false)]
    
    @IBOutlet weak var viewNew: UIView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! CustomTableViewCell
        
        cell.categoryLabel.text = firstTransaction[indexPath.row].category.0
        cell.descriptionLabel.text = firstTransaction[indexPath.row].label
        cell.categoryImage.image = UIImage(systemName: firstTransaction[indexPath.row].category.1)
        cell.costLabel.text = String(firstTransaction[indexPath.row].cost)
        
        return cell
    }
    
    
}


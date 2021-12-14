//
//  BusinessCardViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.12.2021.
//

import UIKit

class BusinessCardViewController: UITableViewController {
    
    private var developers: [Developer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDevelopersFromJSON()
    }
    
    // MARK: - Table view data source
    
    func loadDevelopersFromJSON() {
        DataManager.getDeveloperDataWithSuccess() { (data) in
            guard let data = data, let developerArray = try? JSONDecoder().decode([Developer].self, from: data) else {
                print("JSON loading Error")
                return
            }
            
            self.developers = developerArray
            print(developerArray[0].email)
        }
    }
}

extension BusinessCardViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell", for: indexPath) as! DeveloperTableViewCell
        cell.backgroundColor = .orange
        cell.businessCardView.backgroundColor = .orange
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        self.
//    }
    
}

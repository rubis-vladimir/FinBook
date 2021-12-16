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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        developers?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell", for: indexPath) as! DeveloperTableViewCell
        
        cell.businessCardView.draw(CGRect(origin: CGPoint(x:cell.bounds.width / 2,
                                                          y:cell.bounds.height / 2),
                                          size: CGSize(width: 250, height: 250)),
                                   developer: developers![indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.bounds.width * 0.65
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        <#code#>
    //    }
}

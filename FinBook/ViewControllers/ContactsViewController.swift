//
//  ContactsViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 12.12.2021.
//

import UIKit

class ContactsViewController: UITableViewController {
    
    @IBOutlet weak var contactView: ContactView!
    
    private var developers: [Developer]?
    private var isSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDevelopersFromJSON()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTheme()
        
    }
    
    private func refreshTheme() {
        ColorManager.shared.setThemeColors(mainElement: self.view, secondaryElement: navigationController?.navigationBar)
    }
    
    // MARK: - Table view data source
    
    func loadDevelopersFromJSON() {
        DataManager.getDeveloperDataWithSuccess() { (data) in
            guard let data = data, let developerArray = try? JSONDecoder().decode([Developer].self, from: data) else {
                print("JSON loading Error")
                return
            }
            
            self.developers = developerArray
        }
    }
}

extension ContactsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        developers?.count ?? 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell", for: indexPath) as! DeveloperTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.contactView.draw(CGRect(origin: CGPoint(x:cell.bounds.width / 2,
                                                          y:cell.bounds.height / 2),
                                          size: CGSize(width: 250, height: 250)),
                                   developer: developers![indexPath.row], isSelected: isSelected)
//        cell.contactView.dr
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.bounds.width * 0.65
    }
}

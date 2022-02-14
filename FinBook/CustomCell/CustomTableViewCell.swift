//
//  CustomTableViewCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.08.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    static let shared = CustomTableViewCell()
    
    func createCustomCell(cell: CustomTableViewCell, transaction: Transact) -> CustomTableViewCell {
        
        cell.costLabel.text = String(transaction.cost)
        cell.descriptionLabel.text = transaction.descr
        cell.categoryLabel.text = transaction.category
        cell.categoryImage.image = getImageFromCategory(transaction: transaction)
        cell.dataLabel.text = DateConvertManager.shared.convertDateToStr(date: transaction.date)
//        cell.categoryLabel.text = transaction.note
        
        cell.categoryImage.tintColor =  transaction.incomeTransaction ? .systemGreen : .systemRed
        cell.categoryLabel.textColor = .systemGray
        cell.dataLabel.textColor = .systemGray
        cell.backgroundColor = UIColor.systemGray5
        return cell
    }
    
    func getImageFromCategory (transaction: Transact) -> UIImage {
        for (name , image) in CategoryService.spendCategoryList {
            if name == transaction.category {
                return image
            }
        }
         return UIImage(systemName: "bag") ?? UIImage()
    }
}

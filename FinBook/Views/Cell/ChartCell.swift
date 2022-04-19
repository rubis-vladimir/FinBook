//
//  ChartCell.swift
//  FinBook
//
//  Created by Владимир Рубис on 01.12.2021.
//

import UIKit

// MARK: Класс описывает ячейку таблицы статистики расходов/доходов за выбранный период
class ChartCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    //MARK: - Public funcs
    /// Настраивает ячейки в таблице статистики
    ///  - Parameters:
    ///     - color: цвет вью
    ///     - percent: процент от общих доходов/расходов за выбранный период
    ///     - category: категория
    func configure(color: UIColor,
                   persent: Double,
                   category: String) {
        backgroundColor = UIColor.clear
        colorView.backgroundColor = color
        percentLabel.text = String(format: "%.1f", persent) + " %"
        categoryLabel.text = category
    }
}

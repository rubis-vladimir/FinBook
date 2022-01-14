//
//  StatisticViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class StatisticViewController: UIViewController {
    
    var transactions: [Transact] = []
    var sections: [(String, Double)] = []
    var palitreColors: [UIColor] = []
    private let hexColors: [String] = ["767E8C", "CE5A57", "78A5A3", "E1B16A"]
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var statisticsTV: UITableView!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var finishDate: UIDatePicker!
    @IBOutlet weak var calculateChartButton: UIButton!
    @IBOutlet var screenLabels: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        startDate.date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
        startDate.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        redrawPieChart()
        refreshTheme()
    }
    
    
    @IBAction func calculateChart(_ sender: UIButton) {
        redrawPieChart()
    }
    
    private func refreshTheme() {
        ColorManager.shared.setThemeColors(mainElement: self.view, secondaryElement: navigationController?.navigationBar)
        
        for i in screenLabels {
            i.changeColor()
        }
        
    }
    
    private func redrawPieChart() {
        getData()
        sections = ChartManager.shared.fillteredForChart(transactions: transactions,
                                                         start: startDate.date,
                                                         finish: finishDate.date)
        statisticsTV.reloadData()
        palitreColors = ColorManager.shared.createPalitreColors(hexColors: hexColors)
        pieChartView.layer.sublayers?.removeAll()
        
        self.pieChartView.draw(
            CGRect(origin: CGPoint(x:pieChartView.bounds.width / 2,
                                   y:pieChartView.bounds.height / 2),
                   size: CGSize(width: 250, height: 250)),
            sections: sections,
            colors: palitreColors
        )
    }
    
    private func getData() {
        self.transactions = StorageManager.shared.fetchData()
    }
    
    private func setupElements() {
        calculateChartButton.customizeButton(model: 2, cradius: 10, bgc: false)
        statisticsTV.backgroundColor = UIColor.clear
    }
}

extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! ChartTableViewCell
        cell.categoryView.backgroundColor = palitreColors[indexPath.row]
        
        cell.categoryShare.text = String(format: "%.1f", sections[indexPath.row].1 * 100 / (2 * Double.pi)) + " %"
        cell.categoryLabel.text = sections[indexPath.row].0
        cell.categoryLabel.text = sections.map({$0})[indexPath.row].0
        
        cell.backgroundColor = ColorManager.shared.hexStringToUIColor(hex: Pallete.getPallete(model: ColorManager.shared.retrieveThemeData()).primaryColor)
        cell.categoryLabel.changeColor()
        cell.categoryShare.changeColor()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 40 }
}

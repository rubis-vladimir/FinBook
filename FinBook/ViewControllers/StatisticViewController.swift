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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(button: calculateChartButton)
        startDate.date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
        ColorManager.shared.setThemeColors(mainElement: self.view, secondaryElement: navigationController?.navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        redrawPieChart()
    }
    
    @IBAction func calculateChart(_ sender: UIButton) {
        redrawPieChart()
        setupButton(button: calculateChartButton)
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
    
    private func setupButton(button: UIButton) {
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 20)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(ciColor: .gray).cgColor
        button.layer.cornerRadius = 10
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 40 }
}

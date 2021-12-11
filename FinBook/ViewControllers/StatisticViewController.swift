//
//  StatisticViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class StatisticViewController: UIViewController {
    
    var transactions: [Transact] = []
    var sections: [String: Double] = [:]
    var palitreColors: [UIColor] = []
    private let hexColors: [String] = ["767E8C", "CE5A57", "78A5A3", "E1B16A"]
    let colors: [UIColor] = [.red, .orange, .gray, .blue]
    var reports: [String] = ["Полный", "Годовой", "Месячный"]
    var selectedElement: String?
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var statisticsTV: UITableView!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var finishDate: UIDatePicker!
    @IBOutlet weak var calculateChartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateChartButton.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 20)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        redrawPieChart()
        setupButton(button: calculateChartButton)
    }
    
    
    @IBAction func calculateChart(_ sender: UIButton) {
        redrawPieChart()
        setupButton(button: calculateChartButton)
    }
    
    private func redrawPieChart() {
        getData()
        sections = ChartManager.shared.fillteredForChart(transactions: transactions, start: startDate.date, finish: finishDate.date)
        statisticsTV.reloadData()
        palitreColors = ColorManager.shared.createPalitreColors(hexColors: hexColors)
        pieChartView.layer.sublayers?.removeAll()
        
        self.pieChartView.draw(
            CGRect(origin: CGPoint(x:pieChartView.bounds.width / 2, y:pieChartView.bounds.height / 2), size: CGSize(width: 250, height: 250)),
            sections: sections,
            colors: palitreColors
        )
    }
    
    private func getData() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let transactions):
                self.transactions = transactions
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        
        cell.categoryShare.text = String(format: "%.1f", sections.map({$1})[indexPath.row] * 100 / (2 * Double.pi)) + " %"
        cell.categoryLabel.text = sections.map({$0})[indexPath.row].key
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}

extension StatisticViewController {
    
    
}

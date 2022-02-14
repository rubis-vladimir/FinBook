//
//  StatisticViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class StatisticViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var statisticsTV: UITableView!
    
    //MARK: - Properties
    private let withEmptyChartLabel = UILabel()
    
    private var percentageShares: [(String, Double)] = []
    private var palitreColors: [UIColor] = []
    private var isIncome: Bool = false
    private var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
    private var finishDate: Date = Date()
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        redrawPieChart()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        redrawPieChart()
    }
    
    // MARK: - IBAction
    @IBAction func parametersChart() {
        self.setAlert(isIncome: isIncome,
                      startDate: startDate,
                      finishDate: finishDate) {(isIncome, startDate, finishDate) in
            self.isIncome = isIncome
            self.startDate = startDate
            self.finishDate = finishDate
            self.redrawPieChart()
        }
    }
    
    // MARK: - Private function
    private func redrawPieChart() {
        percentageShares = ChartManager.shared.fillteredForChart(startDate: startDate,
                                                                 finishDate: finishDate,
                                                                 isIncome: isIncome)
        palitreColors = UIColor.Palette.colorsChart()
        statisticsTV.reloadData()
        pieChartView.layer.sublayers?.removeAll()
        
        if percentageShares.isEmpty {
            withEmptyChartLabel.isHidden = false
        } else {
            withEmptyChartLabel.isHidden = true
            self.pieChartView.draw(percents: percentageShares,
                                   colors: palitreColors
            )
        }
    }
    
    private func setupElements() {
        statisticsTV.backgroundColor = UIColor.clear
        withEmptyChartLabel.setupDefaultLabel(view: view,
                                              title: "Отсутствуют данные по операциям за указанный период")
        view.backgroundColor = UIColor.Palette.background
    }
}

//MARK: - UITableViewDataSourse
extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        percentageShares.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! ChartCell
        
        cell.backgroundColor = UIColor.clear
        cell.colorView.backgroundColor = palitreColors[indexPath.row]
        cell.percentLabel.text = String(format: "%.1f", percentageShares[indexPath.row].1) + " %"
        cell.categoryLabel.text = percentageShares[indexPath.row].0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 40 }
}

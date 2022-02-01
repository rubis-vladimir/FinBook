//
//  StatisticViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

class StatisticViewController: UIViewController {
    
    //MARK: - Properties
    private var transactions: [Transact] = []
    private var sections: [(String, Double)] = []
    private var palitreColors: [UIColor] = []
    
    //MARK: - UIElements for AlertController
    private let startDatePicker = UIDatePicker()
    private let finishDatePicker = UIDatePicker()
    private let chartTypeSwitch = UISwitch()
    private let chartTypeLabel = UILabel()
    private let emptyChartLabel = UILabel()
    
    //MARK: - IBOutlets
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var statisticsTV: UITableView!
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        setupLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        redrawPieChart()
        refreshTheme()
    }
    
    // MARK: - IBAction
    @IBAction func parametersChart(_ sender: UIBarButtonItem) {
        setAlert()
    }
    
    // MARK: - Private function
    // Screen refresh functions
    private func refreshTheme() {
        ColorManager.shared.setThemeColors(mainElement: self.view, secondaryElement: navigationController?.navigationBar)
    }
    
    private func redrawPieChart() {
        getData()
        sections = ChartManager.shared.fillteredForChart(transactions: transactions,
                                                         start: startDatePicker.date,
                                                         finish: finishDatePicker.date,
                                                         isIncome: chartTypeSwitch.isOn)
        statisticsTV.reloadData()
        palitreColors = ColorManager.shared.createPalitreColors()
        pieChartView.layer.sublayers?.removeAll()
        
        if sections.isEmpty {
            emptyChartLabel.isHidden = false
        } else {
            emptyChartLabel.isHidden = true
            self.pieChartView.draw(sections: sections,
                                   colors: palitreColors
            )
        }
    }
    
    private func setupLabel() {
        emptyChartLabel.text = "Отсутствуют данные по операциям за указанный период"
        emptyChartLabel.setupDefaultLabel(view: view)
    }
    
    // Getting data from CoreData
    private func getData() {
        self.transactions = StorageManager.shared.fetchData()
    }
    
    // Customization UIElements
    private func setupElements() {
        statisticsTV.backgroundColor = UIColor.clear
        startDatePicker.date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
        finishDatePicker.date = Date()
    }
}

//MARK: - UITableViewDataSourse
extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! ChartCell
        
        let persantageValue = String(format: "%.1f", sections[indexPath.row].1 * 100 / (2 * Double.pi)) + " %"
        cell.backgroundColor = UIColor.clear
        cell.colorView.backgroundColor = palitreColors[indexPath.row]
        cell.percentLabel.text = persantageValue
        cell.categoryLabel.text = sections[indexPath.row].0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 40 }
}

//MARK: - AlertController
extension StatisticViewController {
    private func setAlert() {
        let alert = UIAlertController(title: "", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
        AlertManager.shared.overrideAlertWidthConstrants(alert: alert)
        AlertManager.shared.setupAlertElements(alert: alert,
                                               startDatePicker: startDatePicker,
                                               finishDatePicker: finishDatePicker,
                                               typeSwitch: chartTypeSwitch,
                                               typeLabel: chartTypeLabel)
        
        chartTypeSwitch.addTarget(self, action: #selector(switchValueDidChanged), for: .valueChanged)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Рассчитать", style: .default, handler: {(UIAlertAction) in
            self.redrawPieChart()
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    @objc private func switchValueDidChanged(sender:UISwitch!) {
        chartTypeLabel.text = sender.isOn ? "Доход" : "Расход"
    }
}

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
    private let startDate = UIDatePicker()
    private let finishDate = UIDatePicker()
    private let switchChartType = UISwitch()
    private let chartTypeLabel = UILabel()
    
    //MARK: - IBOutlets
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var statisticsTV: UITableView!
    @IBOutlet weak var parametersChartButton: UIButton!
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    override func viewWillAppear(_ animated: Bool) {
        redrawPieChart()
        refreshTheme()
    }
    
    // MARK: - IBAction
    @IBAction func parametersChart(_ sender: UIButton) {
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
                                                         start: startDate.date,
                                                         finish: finishDate.date,
                                                         isIncome: switchChartType.isOn)
        statisticsTV.reloadData()
        palitreColors = ColorManager.shared.createPalitreColors()
        pieChartView.layer.sublayers?.removeAll()
        
        self.pieChartView.draw(
            sections: sections,
            colors: palitreColors
        )
    }
    
    // Getting data from CoreData
    private func getData() {
        self.transactions = StorageManager.shared.fetchData()
    }
    
    // Customization UIElements
    private func setupElements() {
        parametersChartButton.customizeButton(cradius: 10, bgc: false)
        statisticsTV.backgroundColor = UIColor.clear
        startDate.date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
        finishDate.date = Date()
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
        
        overrideAlertWidthConstrants(alert: alert)
        setupElements(alert: alert)
        switchChartType.addTarget(self, action: #selector(switchValueDidChanged), for: .valueChanged)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Рассчитать", style: .default, handler: { (UIAlertAction) in
            self.redrawPieChart()
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    @objc func switchValueDidChanged(sender:UISwitch!) {
        chartTypeLabel.text = sender.isOn ? "Доход" : "Расход"
    }
    
    // MARK: - Все что ниже надо куда то вынести и отредактировать
    private func overrideAlertWidthConstrants(alert: UIAlertController!) {
        
        let widthConstraints = alert.view.constraints.filter({return $0.firstAttribute == .width})
        alert.view.removeConstraints(widthConstraints)
        let newWidth = UIScreen.main.bounds.width * 0.9
        
        let widthConstraint = NSLayoutConstraint(item: alert.view as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: newWidth)
        alert.view.addConstraint(widthConstraint)
        
        let firstContainer = alert.view.subviews[0]
        // Finding first child width constraint
        let constraint = firstContainer.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        firstContainer.removeConstraints(constraint)
        // And replacing with new constraint equal to alert.view width constraint that we setup earlier
        alert.view.addConstraint(NSLayoutConstraint(item: firstContainer,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: alert.view,
                                                    attribute: .width,
                                                    multiplier: 1.0,
                                                    constant: 0))
        // Same for the second child with width constraint with 998 priority
        let innerBackground = firstContainer.subviews[0]
        let innerConstraints = innerBackground.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        innerBackground.removeConstraints(innerConstraints)
        firstContainer.addConstraint(NSLayoutConstraint(item: innerBackground,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: firstContainer,
                                                        attribute: .width,
                                                        multiplier: 1.0,
                                                        constant: 0))
        
    }
    
    private func setupElements(alert: UIAlertController) {
        
        let label = UILabel()
        let label2 = UILabel()
        let label4 = UILabel()
        let label5 = UILabel()
        let stackDateRange = UIStackView()
        let stackChoiceChart = UIStackView()
        
        startDate.datePickerMode = .date
        startDate.contentHorizontalAlignment = .center
        
        finishDate.datePickerMode = .date
        finishDate.contentHorizontalAlignment = .center
        
        stackChoiceChart.translatesAutoresizingMaskIntoConstraints = false
        stackDateRange.translatesAutoresizingMaskIntoConstraints = false
        switchChartType.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        startDate.translatesAutoresizingMaskIntoConstraints = false
        finishDate.translatesAutoresizingMaskIntoConstraints = false
        label4.translatesAutoresizingMaskIntoConstraints = false
        
        label4.widthAnchor.constraint(equalToConstant: 22).isActive = true
        label5.translatesAutoresizingMaskIntoConstraints = false
        
        label5.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        label.text = "Введите временной диапазон:"
        label2.text = "И тип транзакций:"
        chartTypeLabel.text = "Расход"
        label4.text = "От"
        label5.text = "До"
        
        chartTypeLabel.font = UIFont(name: "Avenir-Heavy", size: 17)
        
        stackDateRange.addArrangedSubview(label4)
        stackDateRange.addArrangedSubview(startDate)
        stackDateRange.addArrangedSubview(label5)
        stackDateRange.addArrangedSubview(finishDate)
        
        stackChoiceChart.addArrangedSubview(label2)
        stackChoiceChart.addArrangedSubview(switchChartType)
        stackChoiceChart.addArrangedSubview(chartTypeLabel)
        stackChoiceChart.spacing = 10
        
        alert.view.addSubview(label)
        alert.view.addSubview(stackDateRange)
        alert.view.addSubview(stackChoiceChart)
        
        stackChoiceChart.topAnchor.constraint(equalTo: stackDateRange.bottomAnchor, constant: 10).isActive = true
        stackChoiceChart.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
        
        label.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        label.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
        
        stackDateRange.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15).isActive = true
        stackDateRange.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
        stackDateRange.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -10).isActive = true
        stackDateRange.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        startDate.widthAnchor.constraint(equalTo: finishDate.widthAnchor).isActive = true
    }
}

//
//  StatisticViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 28.11.2021.
//

import UIKit

// MARK: Класс описывает экран статистики
class StatisticViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var statisticsTV: UITableView!
    
    //MARK: - Properties
    private let chartManager = DataFilteringService()
    private let withEmptyChartLabel = UILabel()
    
    private var percentageArray: [(String, Double)] = []
    private var palitreColors: [UIColor] = []
    private var isIncome: Bool = false
    private var startDate: Date = Calendar.current.date(byAdding: .day,
                                                        value: -30,
                                                        to: Date()) ?? Date()
    private var endDate: Date = Date()
    
    //MARK: - Override funcs
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
    /// Вызов алерта для настройки параметров статистики
    @IBAction func parametersChart() {
        showAlertToSetStatistics(isIncome: isIncome,
                 startDate: startDate,
                 endDate: endDate) {(isIncome, startDate, finishDate) in
            self.isIncome = isIncome
            self.startDate = startDate
            self.endDate = finishDate
            self.redrawPieChart()
        }
    }
    
    // MARK: - Private funcs
    private func redrawPieChart() {
        
        /// Массив актуальных транзакции из `CoreData`
        let transactions = StorageManager.shared.fetchData()
        
        /// Массив кортежей (категория, процент от общей стоимости) за период
        percentageArray = chartManager.getDataInPercentage(from: transactions,
                                                           from: startDate,
                                                           to: endDate,
                                                           isIncome: isIncome)
        /// Массив цветов
        palitreColors = Palette.getChartPalette()
        
        /// Стираем слои вью и обновляем таблицу
        pieChartView.layer.sublayers?.removeAll()
        statisticsTV.reloadData()
        
        if percentageArray.isEmpty {
            withEmptyChartLabel.isHidden = false
        } else {
            withEmptyChartLabel.isHidden = true
            
            /// Перерисовываем диаграмму
            self.pieChartView.draw(percents: percentageArray,
                                   colors: palitreColors
            )
        }
    }
    
    private func setupElements() {
        view.backgroundColor = Palette.background
        statisticsTV.backgroundColor = UIColor.clear
        
        withEmptyChartLabel.setupDefaultLabel(view: view,
                                              title: "Отсутствуют данные по операциям за указанный период",
                                              inCenter: true)
    }
}


//MARK: - UITableViewDataSourse
extension StatisticViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        percentageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath) as! ChartCell
        
        cell.configure(color: palitreColors[indexPath.row],
                       persent: percentageArray[indexPath.row].1,
                       category: percentageArray[indexPath.row].0)
        
        return cell
    }
}

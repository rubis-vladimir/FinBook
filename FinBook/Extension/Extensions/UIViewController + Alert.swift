//
//  UIViewController + Alert.swift
//  FinBook
//
//  Created by Владимир Рубис on 07.02.2022.
//

import UIKit

// MARK: Расширение для вью контроллера (Alert)
extension UIViewController {
    
    /// Настраивает `alert` для вывода статистики
    ///  - Parameters:
    ///     - isIncome: доход / расход
    ///     - startDate: начальная дата
    ///     - endDate: конечная дата
    ///     - completion: замыкание для захвата значений
    func showAlertToSetStatistics(isIncome: Bool,
                  startDate: Date,
                  endDate: Date,
                  completion: @escaping (Bool, Date, Date) -> Void) {
        
        let alert = UIAlertController(title: nil,
                                      message: "\n\n\n\n",
                                      preferredStyle: .alert)
        
        let startDatePicker = UIDatePicker()
        let endDatePicker = UIDatePicker()
        let typeSwitch = SubclassedUISwitch()
    
        startDatePicker.date = startDate
        endDatePicker.date = endDate
        typeSwitch.isOn = isIncome
        
        typeSwitch.addTarget(self, action: #selector(switchValueDidChanged), for: .valueChanged)
        
        setupAlertElements(alert: alert,
                           startDatePicker: startDatePicker,
                           endDatePicker: endDatePicker,
                           typeSwitch: typeSwitch)
        
        overrideAlertWidthConstrants(alert: alert)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Рассчитать", style: .default, handler: {(action) in
            completion (typeSwitch.isOn, startDatePicker.date, endDatePicker.date)
        }))
        self.present(alert, animated: true, completion: nil )
    }
    
    //MARK: - Private funcs
    @objc private func switchValueDidChanged(sender:SubclassedUISwitch!) {
        sender.label.text = sender.isOn ? "Доход" : "Расход"
    }
    
    private func setupAlertElements(alert: UIAlertController,
                                    startDatePicker: UIDatePicker,
                                    endDatePicker: UIDatePicker,
                                    typeSwitch: SubclassedUISwitch) {
        let explanationLabel1 = UILabel()
        let explanationLabel2 = UILabel()
        let fromLabel = UILabel()
        let beforeLabel = UILabel()
        let stackDateRange = UIStackView()
        let stackChoiceChart = UIStackView()
        
        // Настройка параметров элементов
        explanationLabel1.text = "Введите временной диапазон:"
        explanationLabel2.text = "И тип транзакций:"
        typeSwitch.label.text = typeSwitch.isOn ? "Доход" : "Расход"
        fromLabel.text = "От"
        beforeLabel.text = "До"
        
        typeSwitch.label.font = UIFont(name: "Avenir-Heavy", size: 17)
        
        startDatePicker.datePickerMode = .date
        startDatePicker.contentHorizontalAlignment = .center
        startDatePicker.locale = Locale(identifier: "ru_RU")
        endDatePicker.datePickerMode = .date
        endDatePicker.contentHorizontalAlignment = .center
        endDatePicker.locale = Locale(identifier: "ru_RU")
        
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        typeSwitch.translatesAutoresizingMaskIntoConstraints = false
        typeSwitch.label.translatesAutoresizingMaskIntoConstraints = false
        explanationLabel1.translatesAutoresizingMaskIntoConstraints = false
        stackChoiceChart.translatesAutoresizingMaskIntoConstraints = false
        stackDateRange.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        beforeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        /// Добавление элементов в `Stack` и `alert`
        stackDateRange.addArrangedSubview(fromLabel)
        stackDateRange.addArrangedSubview(startDatePicker)
        stackDateRange.addArrangedSubview(beforeLabel)
        stackDateRange.addArrangedSubview(endDatePicker)
        
        stackChoiceChart.addArrangedSubview(explanationLabel2)
        stackChoiceChart.addArrangedSubview(typeSwitch)
        stackChoiceChart.addArrangedSubview(typeSwitch.label)
        stackChoiceChart.spacing = 10
        
        alert.view.addSubview(explanationLabel1)
        alert.view.addSubview(stackDateRange)
        alert.view.addSubview(stackChoiceChart)
        
        /// Настройка констрейнтов
        fromLabel.widthAnchor.constraint(equalToConstant: 22).isActive = true
        beforeLabel.widthAnchor.constraint(equalToConstant: 22).isActive = true
        startDatePicker.widthAnchor.constraint(equalTo: endDatePicker.widthAnchor).isActive = true
        
        explanationLabel1.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 15).isActive = true
        explanationLabel1.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
        
        stackChoiceChart.topAnchor.constraint(equalTo: stackDateRange.bottomAnchor, constant: 10).isActive = true
        stackChoiceChart.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
        
        stackDateRange.topAnchor.constraint(equalTo: explanationLabel1.bottomAnchor, constant: 10).isActive = true
        stackDateRange.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
        stackDateRange.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -10).isActive = true
    }
    
    /// Переопределение ширины `alert`
    private func overrideAlertWidthConstrants(alert: UIAlertController!) {
        
        /// Находим и удаляем констрейнт ширины вью
        let widthConstraints = alert.view.constraints.filter({return $0.firstAttribute == .width})
        alert.view.removeConstraints(widthConstraints)
        
        /// Определяем и устанавливаем новый констрейнт
        let newWidth = UIScreen.main.bounds.width * 0.9
        let widthConstraint = NSLayoutConstraint(item: alert.view as Any,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: newWidth)
        alert.view.addConstraint(widthConstraint)
        
        /// Находим и удаляем констрейнт ширины первого дочернего элемента
        let firstContainer = alert.view.subviews[0]
        let constraint = firstContainer.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        firstContainer.removeConstraints(constraint)

        /// Заменяем новым констрейнтом равным констрейнту ширины, установленному ранее
        alert.view.addConstraint(NSLayoutConstraint(item: firstContainer,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: alert.view,
                                                    attribute: .width,
                                                    multiplier: 1.0,
                                                    constant: 0))

        /// То же самое для второго дочернего элемента
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
}

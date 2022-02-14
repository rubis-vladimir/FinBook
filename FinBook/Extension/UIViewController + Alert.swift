//
//  UIViewController + Alert.swift
//  FinBook
//
//  Created by Владимир Рубис on 07.02.2022.
//

import UIKit

extension UIViewController {
    
    func setAlert(isIncome: Bool, startDate: Date, finishDate: Date, completion: @escaping (Bool, Date, Date) -> Void) {
        
        let startDatePicker = UIDatePicker()
        let finishDatePicker = UIDatePicker()
        let chartTypeSwitch = UISwitch()
        let chartTypeLabel = UILabel()
        
        startDatePicker.date = startDate
        finishDatePicker.date = finishDate
        chartTypeSwitch.isOn = isIncome
        
        let alert = UIAlertController(title: nil, message: "\n\n\n\n", preferredStyle: .alert)
        
        overrideAlertWidthConstrants(alert: alert)
        setupAlertElements(alert: alert,
                           startDatePicker: startDatePicker,
                           finishDatePicker: finishDatePicker,
                           typeSwitch: chartTypeSwitch,
                           typeLabel: chartTypeLabel)
        
        chartTypeSwitch.addTarget(self, action: #selector(switchValueDidChanged), for: .valueChanged)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Рассчитать", style: .default, handler: {(action) in
            completion (chartTypeSwitch.isOn, startDatePicker.date, finishDatePicker.date)
        }))
        self.present(alert, animated: true, completion: nil )
    }
    
    @objc private func switchValueDidChanged(sender:UISwitch!) {
        let chartTypeLabel = UILabel()
        chartTypeLabel.text = sender.isOn ? "Доход" : "Расход"
    }
    
    //MARK: - Setting alert width
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
    
    // MARK: - Setting alert view content
    private func setupAlertElements(alert: UIAlertController, startDatePicker: UIDatePicker, finishDatePicker: UIDatePicker, typeSwitch: UISwitch, typeLabel: UILabel) {
        
        let explanationLabel1 = UILabel()
        let explanationLabel2 = UILabel()
        let fromLabel = UILabel()
        let beforeLabel = UILabel()
        let stackDateRange = UIStackView()
        let stackChoiceChart = UIStackView()
        
        // Setup elements
        explanationLabel1.text = "Введите временной диапазон:"
        explanationLabel2.text = "И тип транзакций:"
        typeLabel.text = "Расход"
        fromLabel.text = "От"
        beforeLabel.text = "До"
        
        typeLabel.font = UIFont(name: "Avenir-Heavy", size: 17)
        
        startDatePicker.datePickerMode = .date
        startDatePicker.contentHorizontalAlignment = .center
        finishDatePicker.datePickerMode = .date
        finishDatePicker.contentHorizontalAlignment = .center
        
        // To dynamically calculate the size and position of our views
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        finishDatePicker.translatesAutoresizingMaskIntoConstraints = false
        typeSwitch.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        explanationLabel1.translatesAutoresizingMaskIntoConstraints = false
        stackChoiceChart.translatesAutoresizingMaskIntoConstraints = false
        stackDateRange.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        beforeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding items to the stack and alert
        stackDateRange.addArrangedSubview(fromLabel)
        stackDateRange.addArrangedSubview(startDatePicker)
        stackDateRange.addArrangedSubview(beforeLabel)
        stackDateRange.addArrangedSubview(finishDatePicker)
        
        stackChoiceChart.addArrangedSubview(explanationLabel2)
        stackChoiceChart.addArrangedSubview(typeSwitch)
        stackChoiceChart.addArrangedSubview(typeLabel)
        stackChoiceChart.spacing = 10
        
        alert.view.addSubview(explanationLabel1)
        alert.view.addSubview(stackDateRange)
        alert.view.addSubview(stackChoiceChart)
        
        // Setup constraints
        fromLabel.widthAnchor.constraint(equalToConstant: 22).isActive = true
        beforeLabel.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        explanationLabel1.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 15).isActive = true
        explanationLabel1.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
        
        stackChoiceChart.topAnchor.constraint(equalTo: stackDateRange.bottomAnchor, constant: 10).isActive = true
        stackChoiceChart.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
        
        stackDateRange.topAnchor.constraint(equalTo: explanationLabel1.bottomAnchor, constant: 10).isActive = true
        
        startDatePicker.widthAnchor.constraint(equalTo: finishDatePicker.widthAnchor).isActive = true
        
        if alert.view.bounds.width > 375 {
            stackDateRange.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
            stackDateRange.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -10).isActive = true
        } else {
            stackDateRange.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
            stackDateRange.widthAnchor.constraint(equalToConstant: 200).isActive = true
        }
    }
}

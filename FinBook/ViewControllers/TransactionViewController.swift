//
//  TransactionViewController.swift
//  FinBook
//
//  Created by Сперанский Никита on 15.07.2021.
//

import UIKit

class TransactionViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var costTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var categoryPickerView: UIPickerView!
    @IBOutlet var dataPicker: UIDatePicker!
    
    @IBOutlet var noteTextField: UITextField!
    @IBOutlet var doneButton: UIButton!
    
    
    // MARK: - Properties
    var delegate: NewTransactionViewControllerDelegate!
    
//    let currentTransaction = Transaction(cost: 150, description: "Шава вЛаваше", category: .products, date: Date(), note: "Вкусно", incomeTransaction: false)
    
    private lazy var categoryPickerModels: [CategoryPickerModel] = {
        var categories: [CategoryPickerModel] = []
        
        for (category, value) in CategoryService.categoryList {
            categories.append(.init(category: category, title: value.0, icon: value.1))
        }
        return categories
    }()
    
// MARK: - Override func viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetupCostTextField()
        SetupPickerView()
        
    }
    
// MARK: - IBActions
    @IBAction func doneButtonAction(_ sender: Any) {
        saveAndExit()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func costTFChange(_ sender: UITextField) {

        }
    
    
    // MARK: - Private func
    private func saveAndExit() {
        
        guard let cost = Double(costTextField.text ?? "0.0") else { return }
        guard let description = descriptionTextField.text else { return }

        let currentTransaction = Transaction(
            cost: cost,
            description: description,
            category: .products,
            date: dataPicker.date,
            note: noteTextField.text,
            incomeTransaction: false
            )
        
        delegate.saveTransaction(currentTransaction)
        
        dismiss(animated: true)

    }
    
    private func SetupCostTextField() {
        costTextField.becomeFirstResponder()  // курсор на данном поле
        costTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no // исключаем пробелы
        
        costTextField.addTarget(
            self,
            action: #selector(costTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
    private func SetupPickerView() {
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self  //показываем что есть связь между нашим PV и VC
    }
}

// MARK: - PickerControl Settings
extension TransactionViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryPickerModels.count    // количество ячеек (компонента)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat { 40.0 } // высота ячейки (компонента)
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat { 130 } // длина ячейки (компонента)
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let model = categoryPickerModels[row]  // получаем актуальную модель чтобы передать
        return CategoriesView.create(icon: model.icon, title: model.title)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let model = categoryPickerModels[row]  //мы получили модель и строку выделенного элемента
    }
}

//extension TransactionViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let category = Category.allCases[row]
//        return category.rawValue
//    }
//}

// MARK: - CostTextField Settings
extension TransactionViewController: UITextFieldDelegate {
    
//    Ограничить ввод 15 знаками в строке Стоимости и избежать второй точки
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        if textFieldText.contains(".") && string == "." { return false }
        
       
        
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 15
        
    }
    
    //скрыть клавиатуру после редактирования
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // Чтобы кнопка Done была активна только в когда поле цены заполнено
    @objc private func costTextFieldDidChanged() {
        guard let costName = costTextField.text else { return }
        doneButton.isEnabled = !costName.isEmpty ? true : false
        
        
    }
    
    
    
    
//    Работа с клавиатурой
    
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == userNameTextField {
//            passwordTextField.becomeFirstResponder()
//        } else {
//            logInPressed()
//        }
//        return true
//    }
}


//// MARK: - Alert Controller - пока не используется
//extension TransactionViewController {
//    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//            textField?.text = ""
//        }
//        alert.addAction(okAction)
//        present(alert, animated: true)
//    }
//}

// MARK: - TableView Settings - реализация примера транзакции
//extension TransactionViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        50
//    }
//}

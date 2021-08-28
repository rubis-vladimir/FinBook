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
    @IBOutlet var labelTextField: UITextField!
    @IBOutlet var categoryPickerView: UIPickerView!
    @IBOutlet var dataPicker: UIDatePicker!
    
    @IBOutlet var noteTextField: UITextField!
    @IBOutlet var doneButton: UIBarButtonItem!
    
// MARK: - Properties
    var currentTransaction = Transaction()
    
// MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        costTextField.becomeFirstResponder()
        costTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no // исключаем пробелы
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        
        costTextField.addTarget(
            self,
            action: #selector(costTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
// MARK: - IBActions
    @IBAction func doneButtonAction(_ sender: Any) {
        
        
//
//        print("Дан сработал")
//
//        if let cost = Double(costTextField.text!) {
//            currentTransaction.cost = Double(cost)
//            print("стоимость извлеклась!!!!!!!!!!!!!!!!!!!!!!!")
//            return
//        } else {
//            print("Нельзя извлечь стоимость!!!!!!!!!!!!!!!!!")
//            showAlert(title: "Стоимость введена не корректно", message: "Введите корректное значение")
//            return
//        }
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func costTFChange(_ sender: UITextField) {

        }
    
    @IBAction func showTransaction(_ sender: Any) {
        
    }
}

// MARK: - Navigation



// MARK: - TableView Settings - пример транзакции
extension TransactionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}


// MARK: - PickerControl Settings
extension TransactionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
}

extension TransactionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let category = Category.allCases[row]
        return category.rawValue
    }
}

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


// MARK: - Alert Controller - пока не используется
extension TransactionViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

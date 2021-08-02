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
    
// MARK: - Properties

    var currentTransaction = Transaction()
    
// MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        costTextField.becomeFirstResponder()
        costTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no // исключаем пробелы
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
    }
    
// MARK: - IBActions
    @IBAction func doneButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    @IBAction func costTFChange(_ sender: UITextField) {

        }
}

// MARK: - Navigation


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


// MARK: - Alert Controller
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

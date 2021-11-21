//
//  TransactionViewController.swift
//  FinBook
//
//  Created by Сперанский Никита on 15.07.2021.
//

import UIKit

class TransactionViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var costTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var categoryPickerView: UIPickerView!
    @IBOutlet var dataPicker: UIDatePicker!
    @IBOutlet var noteTextField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var categoryLabel: UILabel!
    
// MARK: - Properties
    var delegate: NewTransactionViewControllerDelegate!
    var selectedModel: CategoryPickerModel!
    private var income = false
    
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
        SetupDoneToolBar()
    }
    
// MARK: - IBActions
    @IBAction func incomStatusOnSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            categoryLabel.text = "Категория расхода:"
        default:
            categoryLabel.text = "Категория затрат:"
        }
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        saveAndExit()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
// MARK: - Private func
    private func saveAndExit() {
 
        guard let costPrice = Double(costTextField.text ?? "0.00") else { return }
        guard let description = descriptionTextField.text else { return }
//        guard let pickerCategory = selectedModel.title else { return }
//        guard let note = noteTextField.text else { return }
//        if noteTextField.text == nil { noteTextField.text = "" }
        
        //Thread 1: "-[Transact setCost:]: unrecognized selector sent to instance 0x600001d0da40"
        //Thread 1: "-[Transact setCost:]: unrecognized selector sent to instance 0x6000001f2100"
        
        let currentTransaction = Transact()
        // присваиваем новой транзакции данные с интерфейса
        currentTransaction.cost = costPrice
        currentTransaction.descr = description
        currentTransaction.category = selectedModel.title
        currentTransaction.date = dataPicker.date
        currentTransaction.note = noteTextField.text
    
        if segmentedControl.isEnabledForSegment(at: 1) {
            currentTransaction.incomeTransaction = true
        } else {
            currentTransaction.incomeTransaction = false
        }
        
        delegate.saveTransaction(currentTransaction) // передаем новую транзакцию на основной экран
        dismiss(animated: true)
    }
    
    private func SetupCostTextField() {
        costTextField.becomeFirstResponder()  // курсор на данном поле
        costTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no // исключаем пробелы
        
        costTextField.addTarget(self, action: #selector(costTextFieldDidChanged), for: .editingChanged)
    }
    
    private func SetupPickerView() {
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self  //показываем что есть связь между нашим PV и VC
    }
    
    private func SetupDoneToolBar() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: self,
                                            action: nil)
        let doneButton = UIBarButtonItem(title: "Далее", style: .done,
                                         target: self,
                                         action: #selector(textFieldShouldReturn))
        doneToolbar.items = [flexibleSpace, doneButton]
        doneToolbar.sizeToFit()
        costTextField.inputAccessoryView = doneToolbar
        descriptionTextField.inputAccessoryView = doneToolbar
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
        selectedModel = categoryPickerModels[row]
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
    
    //переход с costTextField на descriptionTextField по нажатию кнопки "Далее" с Алёртами
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard Double(costTextField.text ?? "0.0") ?? 0 > 0 else {
            showAlert(title: "Сумма введена не корректно", message: "Введите число больше нуля")
            return false
        }
        
        if costTextField.isEditing  { descriptionTextField.becomeFirstResponder()
        } else { view.endEditing(true) }
        return true
    }
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

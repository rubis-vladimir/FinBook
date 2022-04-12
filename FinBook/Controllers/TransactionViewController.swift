//
//  TransactionViewController.swift
//  FinBook
//
//  Created by Сперанский Никита on 15.07.2021.
//

import UIKit

class TransactionViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
// MARK: - Properties
    var delegate: NewTransactionViewControllerDelegate!
    
    var editTransaction: Transact?
    private var selectedModel: CategoryPickerModel!
    private let categoryPickerView = UIPickerView()
    private let datePickerView = UIDatePicker()

    private var isIncome = false
    
    private var categoryPickerModels: [CategoryPickerModel] {
        get {
            var categories: [CategoryPickerModel] = []
            let list = isIncome ? CategoryService.incomeCategoryList : CategoryService.spendCategoryList
            
            for (category, image) in list {
                categories.append(.init( title: category, icon: image))
            }
            return categories
        }
    }
    
// MARK: - Override func viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTransactionVC()
    }
    
// MARK: - IBActions
    @IBAction func incomeStatusOnSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            categoryLabel.text = "Категория расхода:"
            isIncome = false
        default:
            categoryLabel.text = "Категория дохода:"
            isIncome = true
        }
        setupCategoryPickerView()  // установка актуальной категории в поле
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        saveAndExit()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
// MARK: - Private func
    private func setupTransactionVC() {
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        
        doneButton.isEnabled = false
        
        setupCostTextField()
        setupCategoryPickerView()
        setupDateTextField()
        setupDoneToolBar()
        edittingTransactionMode()
    }
    
    private func saveAndExit() {
        guard let costPrice = Double(costTextField.text ?? "0.00") else { return }
        guard let description = descriptionTextField.text else { return }
        

        let transaction = StorageManager.shared.createTransact(cost: costPrice,
                                                               description: description,
                                                               category: selectedModel.title,
                                                               date: datePickerView.date,
                                                               note: noteTextField.text ?? "",
                                                               income: isIncome)
        delegate.saveTransaction(transaction)
        dismiss(animated: true)
    }
    
    private func edittingTransactionMode() {
        guard let editTransaction = editTransaction else { return }
        if editTransaction.incomeTransaction == true {
            segmentedControl.selectedSegmentIndex = 1
            isIncome = true
        }
        costTextField.text = String(editTransaction.cost)
        descriptionTextField.text = editTransaction.descr
        datePickerView.date = editTransaction.date ?? datePickerView.date
        dateTextField.text = DateConvertManager.convertDateToStr(datePickerView.date)
        noteTextField.text = editTransaction.note
             
        setCategoryEditTransaction()
        doneButton.isEnabled = true
    }
    
    private func setCategoryEditTransaction() {
        for (index, value) in categoryPickerModels.enumerated() {
            if value.title == editTransaction?.category {
                categoryPickerView.selectRow(index, inComponent: 0, animated: true)
                selectedModel = categoryPickerModels[index]
            }
        }
        setupCategoryTextField()
    }
    
    private func setupCostTextField() {
        costTextField.becomeFirstResponder()
        costTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        costTextField.addTarget(self, action: #selector(costTextFieldDidChanged), for: .editingChanged)
    }
    
    private func setupCategoryPickerView() {
        if  editTransaction?.incomeTransaction == isIncome {
            setCategoryEditTransaction()
        } else {
            selectedModel = categoryPickerModels[0]
            setupCategoryTextField()
        }
        categoryTextField.inputView = categoryPickerView
    }
    
    private func setupCategoryTextField() {
        categoryTextField.text = selectedModel.title
        categoryImage.image = selectedModel.icon
    }
        
    private func setupDateTextField() { // настройка текстового поля с датой
        dateTextField.text = DateConvertManager.convertDateToStr(datePickerView.date)
        
        dateTextField.inputView = datePickerView
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .dateAndTime
        datePickerView.locale = Locale(identifier: "ru_RU")
        
        datePickerView.addTarget(self, action: #selector(dateTextFieldDidChanged), for: .valueChanged)
    }
    
    private func setupDoneToolBar() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let hideKeyboardButton  = UIBarButtonItem(title: "Скрыть", style: .plain,
                                         target: self,
                                         action:#selector(hideKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: self,
                                            action: nil)
        let doneButton = UIBarButtonItem(title: "Далее", style: .done,
                                         target: self,
                                         action: #selector(textFieldShouldReturn))
        doneToolbar.items = [hideKeyboardButton, flexibleSpace, doneButton]
        doneToolbar.sizeToFit()
        costTextField.inputAccessoryView = doneToolbar
        descriptionTextField.inputAccessoryView = doneToolbar
        categoryTextField.inputAccessoryView = doneToolbar
        dateTextField.inputAccessoryView = doneToolbar
    }
}

// MARK: - PickerControl Settings
extension TransactionViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryPickerModels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat { 20.0 }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat { 130 }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let model = categoryPickerModels[row]
        return CategoriesView.create(icon: model.icon, title: model.title)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedModel = categoryPickerModels[row]
        categoryTextField.text = selectedModel.title
        categoryImage.image = selectedModel.icon
    }
}

// MARK: - CostTextField Settings
extension TransactionViewController: UITextFieldDelegate {
     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc private func costTextFieldDidChanged() {
        guard let costName = costTextField.text else { return }
        doneButton.isEnabled = !costName.isEmpty ? true : false
    }
    
    @objc private func dateTextFieldDidChanged() {
        dateTextField.text = DateConvertManager.convertDateToStr(datePickerView.date)
    }
    
    @objc private func hideKeyboard() { view.endEditing(true) }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                  return false
              }
        if textFieldText.contains(".") && string == "." { return false }
        if textFieldText.contains(",") && string == "," { return false }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 30
    }
    
   @objc func textFieldShouldReturn() -> Bool {
        if costTextField.isEditing  {
            guard costFormatter(cost: costTextField.text) > 0 else {
                showAlert(title: "Сумма введена не корректно", message: "Введите сумму больше нуля")
                return false
            }
            descriptionTextField.becomeFirstResponder()
        } else if descriptionTextField.isEditing {
            categoryTextField.becomeFirstResponder()
        } else if categoryTextField.isEditing {
            dateTextField.becomeFirstResponder()
        } else { view.endEditing(true) }
        return true
    }
        
    private func costFormatter(cost: String?) -> Double {
        let formatter = NumberFormatter()
        var doubCost: Double = 0.00000
        formatter.locale = Locale.current
        if let number = formatter.number(from: cost ?? "0.0") {
            doubCost = number.doubleValue
            print (number)
        }
        return doubCost
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

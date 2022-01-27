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
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet var noteTextField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    
    
// MARK: - Properties
    var delegate: NewTransactionViewControllerDelegate!
    
    var editTransaction: Transact?
    private var selectedModel: CategoryPickerModel!
    private let categoryPickerView = UIPickerView()
    private let datePickerView = UIDatePicker()
//    private var selectedCategory
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
        SetupCategoryPickerView()
        SetupDataTextField()
        
        SetupDoneToolBar()
        EditTransaction() // если редактируем существующую транзакцию
    }
    
// MARK: - IBActions
    @IBAction func incomStatusOnSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            categoryLabel.text = "Категория расхода:"
            income = false
        default:
            categoryLabel.text = "Категория дохода:"
            income = true
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
        
        // присваиваем новой транзакции данные с интерфейса и сохраняем ее
        let transaction = StorageManager.shared.createTransact(cost: costPrice, description: description, category: selectedModel.title, date: datePickerView.date, note: noteTextField.text ?? "", income: income)
            
        delegate.saveTransaction(newTransaction: transaction) // передаем новую транзакцию на основной экран     
        dismiss(animated: true)
    }
    
    private func EditTransaction() {                                    // установки при редактировании транзакции
        guard let editTransaction = editTransaction else { return }
        if editTransaction.incomeTransaction == true {
            segmentedControl.selectedSegmentIndex = 1
            income = true
        }
        costTextField.text = String(editTransaction.cost)
        descriptionTextField.text = editTransaction.descr
        datePickerView.date = editTransaction.date ?? datePickerView.date
        dateTextField.text = DateConvertManager.shared.convertDateToStr(date: datePickerView.date)
        noteTextField.text = editTransaction.note
                
        for (index, value) in CategoryService.categoryList.values.enumerated() {
            if value.0 == editTransaction.category {
                categoryPickerView.selectRow(index, inComponent: 0, animated: true)
            }
            doneButton.isEnabled = true
        }
    }
    
    private func SetupCostTextField() {
        costTextField.becomeFirstResponder()  // курсор на данном поле
        costTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no // исключаем пробелы
        doneButton.isEnabled = false  // кнопка выключена
        costTextField.addTarget(self, action: #selector(costTextFieldDidChanged), for: .editingChanged)
    }
    
    private func SetupCategoryPickerView() { // настройка текстового поля с категорией
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self //показываем что есть связь между нашим PV и VC

        selectedModel = categoryPickerModels[0]  // чтобы если ничего не выбрали былa первая по дефолту
        categoryTextField.text = selectedModel.title
        categoryImage.image = selectedModel.icon
        
        categoryTextField.inputView = categoryPickerView
    }
        
    private func SetupDataTextField() { // настройка текстового поля с датой
        dateTextField.text = DateConvertManager.shared.convertDateToStr(date: datePickerView.date)
        
        dateTextField.inputView = datePickerView
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .dateAndTime
        let localeID = Locale.preferredLanguages.first
        datePickerView.locale = Locale(identifier: localeID!)
        
        datePickerView.addTarget(self, action: #selector(dateTextFieldDidChanged), for: .valueChanged)
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
        categoryTextField.inputAccessoryView = doneToolbar
        dateTextField.inputAccessoryView = doneToolbar
    }
}

// MARK: - PickerControl Settings
extension TransactionViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryPickerModels.count    // количество ячеек (компонента)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat { 20.0 } // высота ячейки (компонента)
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat { 130 } // длина ячейки (компонента)
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let model = categoryPickerModels[row]  // получаем актуальную модель чтобы передать
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
    
//    Ограничить ввод 15 знаками в строке Стоимости и избежать второй точки
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        if textFieldText.contains(".") && string == "." { return false }
        if textFieldText.contains(",") && string == "," { return false }

//        if string == "," { string = "." }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 30
    }
    
    // Скрыть клавиатуру после редактирования
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // Чтобы кнопка Done была активна только в когда поле цены заполнено -------------------------------------------------------------------------ТУТ
    @objc private func costTextFieldDidChanged() {
        guard let costName = costTextField.text else {
            doneButton.isEnabled = false
            return
        }
        doneButton.isEnabled = !costName.isEmpty ? true : false
    }
    
    @objc private func dateTextFieldDidChanged() {
        dateTextField.text = DateConvertManager.shared.convertDateToStr(date: datePickerView.date)
    }
    
    
    //переход на следующее поле по нажатию кнопки "Готово" с Алёртами
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
    
    
    private func costFormatter(cost: String?) -> Double { // корректировка  вводимого числа  если вместо точки запятая
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

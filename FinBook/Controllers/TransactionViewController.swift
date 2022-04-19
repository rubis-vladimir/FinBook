//
//  TransactionViewController.swift
//  FinBook
//
//  Created by Сперанский Никита on 15.07.2021.
//

import UIKit

// MARK: VC для создания новой или редактирования существующей транзакции
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
    /// переменная расхода/дохода транзакции
    private var isIncome = false
    ///массив моделей категорий для categoryPickerView
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
    /// При переключении элемента `SegmentedControl` доход/расход изменяет соответствующие категории и некоторые наименования
    @IBAction func incomeStatusOnSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            categoryLabel.text = "Категория расхода:"
            isIncome = false
        default:
            categoryLabel.text = "Категория дохода:"
            isIncome = true
        }
        /// Установка актуальной категории в поле при переключениях
        setupCategoryPickerView()
    }
    
    /// Выход из VC при нажатии кнопки `Готово`
    @IBAction func doneButtonAction(_ sender: Any) {
        saveAndExit()
    }

    /// Выход из VC при нажатии кнопки `Отмена`
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
// MARK: - Private func
    /// Стартовая настройка VC и всех его полей
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
    
    /// Собираем, сохраняем и передаем транзакцию в AccountVC
    private func saveAndExit() {
        /// Проверяем введенные данные  в поля `costTextField` и `descriptionTextField`
        guard let costPrice = Double(costTextField.text ?? "0.00") else { return }
        guard let description = descriptionTextField.text else {
            showAlert(title: "Описание транзакции введено некорректно.", message: "Попробуйте другое описание.")
            return
        }
        
        /// Собираем транзакцию и сразу сохраняем в Storage Manager
        let transaction = StorageManager.shared.createTransact(cost: costPrice,
                                                               description: description,
                                                               category: selectedModel.title,
                                                               date: datePickerView.date,
                                                               note: noteTextField.text ?? "",
                                                               income: isIncome)
        /// Передаем транзакцию в AccountVC через делегат
        delegate.saveTransaction(transaction)
        dismiss(animated: true)
    }
    
    /// Заполняем поля при редактировании транзакции
    private func edittingTransactionMode() {
        guard let editTransaction = editTransaction else { return }
        if editTransaction.incomeTransaction == true {
            segmentedControl.selectedSegmentIndex = 1
            isIncome = true
        }
        costTextField.text = String(editTransaction.cost)
        descriptionTextField.text = editTransaction.descr
        datePickerView.date = editTransaction.date ?? datePickerView.date
        dateTextField.text = DateConvertService.convertDateToStr(datePickerView.date)
        noteTextField.text = editTransaction.note
             
        setCategoryEditTransaction()
        doneButton.isEnabled = true
    }
    
    /// Ищем категорию редактируемой тразакции и выставляем ее в поле категории `categoryTextField` и `categoryImage`
    private func setCategoryEditTransaction() {
        for (index, value) in categoryPickerModels.enumerated() {
            if value.title == editTransaction?.category {
                categoryPickerView.selectRow(index, inComponent: 0, animated: true)
                selectedModel = categoryPickerModels[index]
            }
        }
        setupCategoryTextField()
    }
    
    /// Стартовая настройка поля стоимости `costTextField`
    private func setupCostTextField() {
        costTextField.becomeFirstResponder()
        costTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        
        /// следить за изменениями `.editingChanged` в в поле `costTextField`
        costTextField.addAction(UIAction { [weak self] _ in
            /// При изменении значения `costTextField` активировать или кнопку `Готово`
            guard let costText = self?.costTextField.text else { return }
            self?.doneButton.isEnabled = !costText.isEmpty ? true : false
        }, for: .editingChanged)
    }
    
    /// Функция меняет список категорий дохода/расхода или устанавливает категорию редактируемой тразакции в поля
    private func setupCategoryPickerView() {
        if  editTransaction?.incomeTransaction == isIncome {
            setCategoryEditTransaction()
        } else {
            selectedModel = categoryPickerModels[0]
            setupCategoryTextField()
        }
        categoryTextField.inputView = categoryPickerView
    }
    
    /// Установка изображения и названия ВЫБРАНОЙ категории в соответствующие поля `categoryTextField` и `categoryImage`
    private func setupCategoryTextField() {
        categoryTextField.text = selectedModel.title
        categoryImage.image = selectedModel.icon
    }
        
    /// Стартовая настройка поля даты `dateTextField` и `datePickerView`
    private func setupDateTextField() {
        dateTextField.text = DateConvertService.convertDateToStr(datePickerView.date)
        
        dateTextField.inputView = datePickerView
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .dateAndTime
        datePickerView.locale = Locale(identifier: "ru_RU")
        
        /// Отображаем `Date` в `dateTextField` как `String`
        datePickerView.addAction(UIAction { [weak self] _ in
            self?.dateTextField.text = DateConvertService.convertDateToStr(self?.datePickerView.date)
        }, for: .valueChanged)
    }
    
    ///  Настройка поля над клавиатурой ( Toolbar ) как акссесуара к текстовым полям
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
                                         action: #selector(textFieldShouldReturn(_:)))
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
    /// Количество компонентов PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    /// Количество строк (ячеек) в компоненте PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryPickerModels.count
    }
    /// Высота ячейки PickerView с категорией
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat { 20.0 }
    /// Ширина ячейки PickerView с категорией
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat { 130 }
    /// Заполнение ячеек PickerView
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let model = categoryPickerModels[row]
        return CategoriesView.create(icon: model.icon, title: model.title)
    }
    /// Заполнение заполнение текстового поля `costTextField` и  установка картинки в `categoryImage` выбраной категории в `PickerView`
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedModel = categoryPickerModels[row]
        setupCategoryTextField()
    }
}

// MARK: - CostTextField Settings
extension TransactionViewController: UITextFieldDelegate {
    /// Скрыть клавиатуру при нажатии по пустому месту
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    /// Прячем клавиатуру по нажатии кнопки `Скрыть` на `Toolbar`
    @objc private func hideKeyboard() { view.endEditing(true) }
    /// Функция отслеживает входные данные в КАЖДЫЙ `textField` (являющийся делегатом) в текущем времени для оперативной корректировки
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfText = Range(range, in: textFieldText) else { return false }
        /// Исключаем возможность ввода лишних символов  в `costTextField`
        if textField == costTextField {
            let allowedChars = ["1","2", "3", "4", "5", "6", "7", "8", "9", "0", ".", ",", ""]
            if !allowedChars.contains(string) { return false }
            if textFieldText.contains(".") && string == "." || textFieldText.contains(",") && string == "," { return false }
            if textFieldText.isEmpty && string == "," || textFieldText.isEmpty && string == "." { return false }
        }
        /// Запрещаем ввод лишних данных в поля `categoryTextField`
        if textField == categoryTextField {
            setupCategoryTextField()
            return false
        }
        /// Запрещаем ввод лишних данных в поля `dateTextField`
        if textField == dateTextField {
            dateTextField.text = DateConvertService.convertDateToStr(datePickerView.date)
            return false
        }
        /// Ограничиваем количество символов во  всех `textField`
        let substringToReplace = textFieldText[rangeOfText]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 30
    }
    ///Действие при нажатии кнопки `return button` на клавиатуре - переходим на следующее поле или скрываем её если последнее поле
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
    /// Переводим значение  из `String` в `Double` (исп-ся в `costTextField`) и формирует точку или запятую в зависимости от региона
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
    /// Выводим сообщение об ошибке в `Alert Controller`
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

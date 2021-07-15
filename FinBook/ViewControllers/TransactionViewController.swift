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
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var dataPicker: UIDatePicker!
    
    @IBOutlet var noteTextField: UITextField!
    
// MARK: - Properties
    var currentTransaction: Transaction
    
// MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
// MARK: - IBActions
    
    @IBAction func doneButtonAction(_ sender: Any) {
         currentTransaction = Transaction(
            cost: Double(costTextField.text!)!,
            label: labelTextField.text!,
            category: categoryTextField.text,
            date: dataPicker.date,
            note: noteTextField.text ?? "",
            incomeTransaction: false)
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func noteButtonAction() {
        
    }
    
    /*
// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  TransactionCreationViewController.swift
//  Sanity
//
//  Created by Max Wong on 10/14/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class TransactionCreationViewController: UIViewController {
    @IBOutlet weak var transactionNameTextField: UITextField!
    @IBOutlet weak var TransactionAmountTextField: UITextField!
    @IBOutlet weak var TransactionDescriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transactionNameTextField.delegate = self as? UITextFieldDelegate
        self.TransactionAmountTextField.delegate = self as? UITextFieldDelegate
        self.TransactionDescriptionTextField.delegate = self as? UITextFieldDelegate
        recordDate(self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic
    //Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic
    //Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic//Keyboard Logic
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func clearField(_ sender: Any) {
        TransactionAmountTextField.text = ""
    }
    
    var doubletoStore : Double = 0
    @IBAction func formatNumbers(_ sender: Any) {
        let amountDisplay = Double(TransactionAmountTextField.text!)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        TransactionAmountTextField.text = formatter.string(from: NSNumber(value:amountDisplay!))
        doubletoStore = amountDisplay!
    }
    
    //datePicker//datePicker//datePicker//datePicker//datePicker//datePicker
    @IBOutlet weak var myDate: UIDatePicker!
    var selectedDate : String = ""
    @IBAction func recordDate(_ sender: Any) {
        myDate.datePickerMode = UIDatePickerMode.date
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        selectedDate = dateFormatter.string(from: myDate.date)
    }
    
    
    //Storage Logic//Storage Logic//Storage Logic//Storage Logic//Storage Logic
    //Storage Logic//Storage Logic//Storage Logic//Storage Logic//Storage Logic
    //Storage Logic//Storage Logic//Storage Logic//Storage Logic//Storage Logic
    //Storage Logic//Storage Logic//Storage Logic//Storage Logic//Storage Logic
    var name : String = ""
    var amnt : Double = 0
    var desc : String = ""
    @IBAction func confirmAddTransaction(_ sender: Any) {
        name = transactionNameTextField.text!
        amnt = doubletoStore
        desc = TransactionDescriptionTextField.text!
        recordDate(myDate)
        print(name)
        print(amnt)
        print(desc)
        let purchase = Purchase(name: name , price: amnt ,date: selectedDate, memo: desc)
        Dummy.user.budgetList[Dummy.currentBudgetName]?.categoryList[Dummy.currentCategoryName]?.purchaseList[name] = purchase
        for(String, _) in (Dummy.user.budgetList){
            for(String, _) in (Dummy.user.budgetList[String]?.categoryList)! {
                Dummy.user.budgetList[globalBudget]?.categoryList[String]?.calcUsed()
            }
            Dummy.user.budgetList[String]?.update()
        }
        Dummy.user2 = Dummy.user
        //User.purchaseOverLimitNotification()
        DispatchQueue.main.async {
            Dummy.dc.pushUserToFirebase(user: Dummy.user)
            print("Add purchase \(Dummy.user)")
        }
        //Next, Let's update the previous page! the Category creation Page!
        let updater = NSNotification.Name("reloadCat")
        NotificationCenter.default.post(name: updater, object: nil)
    }

}

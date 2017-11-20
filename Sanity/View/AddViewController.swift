//
//  AddViewController.swift
//  Sanity
//
//  Created by QIZUN XIE on 20/11/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet weak var CategoryTF: UITextField!
    @IBOutlet weak var BudgetTF: UITextField!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var AmntTF: UITextField!
    @IBOutlet weak var Calendar: UIDatePicker!
    @IBOutlet weak var Description: UITextField!
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return Dummy.user.budgetList.count
        }
        else{
            if(BudgetTF.text == ""){}
            else{
                return (Dummy.user.budgetList[selectedBudget1]?.categoryList.count)!
            }
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView.tag == 2){
            if(BudgetTF.text == ""){}
            else{
                return categoryListHere1[row]
            }
        }
        return budgetlistHere1[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 1){
            selectedBudget1 = budgetlistHere1[row]
            BudgetTF.text = selectedBudget1
            CategoryTF.text = ""
            selectedCat1 = ""
            let temp = Dummy.user.budgetList[selectedBudget1]
            categoryListHere1.removeAll()
            for (x,_) in (temp?.categoryList)! {
                categoryListHere1.append(x)
            }
        }
        else{
            if(BudgetTF.text == ""){}
            else{
                selectedCat1 = categoryListHere1[row]
                CategoryTF.text = selectedCat1;
            }
        }
    }
    func createBudgetPicker(){
        let BudgetPicker1 = UIPickerView()
        BudgetPicker1.delegate = self
        BudgetPicker1.tag = 1;
        BudgetTF?.inputView = BudgetPicker1
        let BudgetPicker2 = UIPickerView()
        BudgetPicker2.tag = 2;
        BudgetPicker2.delegate = self
        CategoryTF?.inputView = BudgetPicker2
    }

    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let donebutton = UIBarButtonItem(title:"Done", style: .plain, target:self, action:#selector(self.dismissKeyboard))
        toolBar.setItems([donebutton],animated:false)
        toolBar.isUserInteractionEnabled = true
        BudgetTF.inputAccessoryView = toolBar
        CategoryTF.inputAccessoryView = toolBar
        //NameTF.inputDelegate = self;
        //AmntTF.isUserInteractionEnabled = true;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DoneButton.isEnabled = false;
        for (x,_) in Dummy.user.budgetList{
            budgetlistHere1.append(x)
        }
        AmntTF.keyboardType = UIKeyboardType.decimalPad;
        createBudgetPicker()
        createToolbar()
        // Do any additional setup after loading the view.
    }
    
    func check(){
        if(BudgetTF.text ==
            "" || CategoryTF.text == "" || NameTF.text == "" || AmntTF.text == ""){
            self.DoneButton.isEnabled = false;
        }
        else{
            self.DoneButton.isEnabled = true;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard(){
        self.check()
        view.endEditing(true);
        
    }
    @IBAction func dismissKy(_ sender: Any) {
        self.check()
        self.resignFirstResponder()
    }
    
    @IBAction func dissmissKB(_ sender: Any) {
        self.check()
        self.resignFirstResponder()
    }
    @IBAction func dissmissKYB(_ sender: Any) {
        self.check()
        self.resignFirstResponder()
    }
    @IBAction func CancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    @IBAction func DonePressed(_ sender: Any) {
        self.check()
        if(self.DoneButton.isEnabled){
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
var selectedBudget1: String = ""
var selectedCat1: String = ""
var budgetlistHere1 = [String]()
var categoryListHere1 = [String]()

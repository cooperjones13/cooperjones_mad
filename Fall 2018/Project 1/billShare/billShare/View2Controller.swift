//
//  View2Controller.swift
//  billShare
//
//  Created by Cooper Jones on 10/16/18.
//  Copyright © 2018 Cooper Jones. All rights reserved.
//

import UIKit

class View2Controller: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billNameTF: UITextField!
    @IBOutlet weak var datePick: UIDatePicker!
    @IBOutlet weak var billAmountTF: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneBill"{
            let newBill = Bill()
            let scene1ViewController = segue.destination as! ViewController
            //check to see that text was entered in the textfields
            if billNameTF.text!.isEmpty == false{
                newBill.name = billNameTF.text
            }
            if billAmountTF.text!.isEmpty == false{
                newBill.amount = Double(billAmountTF.text!)
            }
            newBill.dueDate = datePick.date
            if (billAmountTF.text!.isEmpty == false && billNameTF.text!.isEmpty == false){
                scene1ViewController.billArray.append(newBill)
            }
            
        }
    }
    
    override func viewDidLoad() {
        billNameTF.delegate = self
        billAmountTF.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

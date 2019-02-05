//
//  ViewController.swift
//  grav_calc
//
//  Created by Cooper Jones on 10/2/18.
//  Copyright © 2018 Cooper Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var massTF: UITextField!
    @IBOutlet weak var unitSC: UISegmentedControl!
    @IBOutlet weak var gravTF: UITextField!
    @IBOutlet weak var outputNum: UILabel!
    @IBOutlet weak var outputUnit: UILabel!

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateWeight()
    }
    
    @IBAction func unitsChanged(_ sender: Any) {
        updateWeight();
    }
    
    
    
    func updateWeight(){
        var grav: Double?;
        var mass: Double?;
        
        if(massTF.text!.isEmpty){
            mass = 0.0;
        }
        else{
            mass = Double(massTF.text!)!;
        }
        if(gravTF.text!.isEmpty){
            grav = 0.0;
        }
        else{
            grav = abs(Double(gravTF.text!)!);
        }
        
        var output: Double;
        
        if (mass! >= 0.0){
            if(unitSC.selectedSegmentIndex == 0){
                output = mass!*grav!*0.22;
                outputNum.text = String(output);
                outputUnit.text = "lbs";
            }
            else if(unitSC.selectedSegmentIndex == 1){
                output = mass!*grav!;
                outputNum.text = String(output);
                outputUnit.text = "N";
            }
        }
        else{
            //create a UIAlertController object
            let alert=UIAlertController(title: "Warning", message: "The mass cannot be negative", preferredStyle: UIAlertControllerStyle.alert)
            //create a UIAlertAction object for the button
            let cancelAction=UIAlertAction(title: "Cancel", style:UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancelAction) //adds the alert action to the alert object
            let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                self.massTF.text = "0.0";
                self.updateWeight();
                
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    override func viewDidLoad() {
        massTF.delegate = self
        gravTF.delegate = self
        updateWeight();
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  midterm_cooper
//
//  Created by Cooper Jones on 10/18/18.
//  Copyright © 2018 Cooper Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var workoutTimeTF: UITextField!
    @IBOutlet weak var weeklySwitch: UISwitch!
    @IBOutlet weak var workoutSlider: UISlider!
    @IBOutlet weak var runBikeSwim: UISegmentedControl!
    
    
    @IBOutlet weak var workoutsPerWeek: UILabel!
    @IBOutlet weak var milesRan: UILabel!
    @IBOutlet weak var calBurned: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func updateOutput(){
        let min: Double!
        if(workoutTimeTF.text!.isEmpty == false){
            min = Double(workoutTimeTF.text!)!
        }
        else{
            min = 0.0
        }
        
        //Default values for Run
        var calRate = 600.0 //calories per hour
        var speed = 10.0 //minutes per mile
        image.image = UIImage(named: "run")
        
        
        if(runBikeSwim.selectedSegmentIndex == 1){
            //Bike
            calRate = 510.0
            speed = 4.0
            image.image = UIImage(named: "bike")
        }
        if(runBikeSwim.selectedSegmentIndex == 2){
            //Swim
            calRate = 420.0
            speed = 30.0
            image.image = UIImage(named: "swim")
        }
        
        if(min < 30.0){
            //create a UIAlertController object
            let alert=UIAlertController(title: "Seriously?", message: "Keep working out until you've hit 30 minutes!", preferredStyle: UIAlertControllerStyle.alert)
            //create a UIAlertAction object for the button
            let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                self.workoutTimeTF.text = "30.0"
                self.updateOutput()
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }

        var miles = min!/speed
        var cal = min!*calRate/60

        workoutsPerWeek.text = ""

        if(weeklySwitch.isOn){
            //do weekly workouts
            let numPerWeek = Double(workoutSlider.value)
            miles = miles*numPerWeek
            cal = miles*numPerWeek
            workoutsPerWeek.text = NSString(format: "%.2f", workoutSlider.value) as String //https://stackoverflow.com/questions/24047374/string-formatting-of-a-double
        }

        milesRan.text = (NSString(format: "%.2f", miles) as String) + " Miles"
        calBurned.text = (NSString(format: "%.2f", cal) as String) + " Calories"

        
    }
    
    
    @IBAction func goPress(_ sender: Any) {
        updateOutput()
    }
    @IBAction func sliderChanged(_ sender: Any) {
        updateOutput()
    }
    
    @IBAction func switchFlipped(_ sender: Any) {
        updateOutput()
    }
    
    @IBAction func changeType(_ sender: Any) {
        updateOutput()
    }
    
    
    override func viewDidLoad() {
                workoutTimeTF.delegate = self;
        
                workoutsPerWeek.text = NSString(format: "%.2f", Double(workoutSlider.value)) as String //https://stackoverflow.com/questions/24047374/string-formatting-of-a-double
        
                let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
                tap.cancelsTouchesInView = false
                self.view.addGestureRecognizer(tap)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


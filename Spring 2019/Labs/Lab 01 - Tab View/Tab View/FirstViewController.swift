//
//  FirstViewController.swift
//  Tab View
//
//  Created by Cooper Jones on 2/4/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var outputLabel: UILabel!
    
    let statecomp = 0
    let citycomp = 1
    
    var stateCities = StateCityController()
    var states = [String]()
    var cities = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == statecomp{
            return states.count
        }else{
            return cities.count
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stateCities.loadData()
        states = stateCities.getStates()
        cities = stateCities.getCities(index: 0)
        
        outputLabel.text = "\(cities[0]), \(states[0])"
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if component == statecomp{
            return states[row]
        }else{
            return cities[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if component == statecomp{
            cities = stateCities.getCities(index: row)
            picker.reloadComponent(citycomp)
            picker.selectRow(0, inComponent: citycomp, animated: true)
        }
        let staterow = pickerView.selectedRow(inComponent: statecomp)
        let cityrow = pickerView.selectedRow(inComponent: citycomp)
    
        outputLabel.text = "\(cities[cityrow]), \(states[staterow])"
    }

}


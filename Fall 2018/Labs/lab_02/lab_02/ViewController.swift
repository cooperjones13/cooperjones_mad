//
//  ViewController.swift
//  lab_02
//
//  Created by Cooper Jones on 9/20/18.
//  Copyright © 2018 Cooper Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var breedSegCont: UISegmentedControl!
    @IBOutlet weak var fontSlider: UISlider!
    @IBOutlet weak var capsSwitch: UISwitch!
    @IBOutlet weak var colorSegCont: UISegmentedControl!
    
    @IBAction func selectBreed(_ sender: Any) {
        switch breedSegCont.selectedSegmentIndex
        {
        case 0:
            textLabel.text = "Golden Retriever"
            imageView.image = UIImage(named: "retriever")
        case 1:
            textLabel.text = "Dachshund"
            imageView.image = UIImage(named: "dachshunds")
        default:
            break
        }
    }
    
    @IBAction func changeFontSize(_ sender: Any) {
        let fontSize = CGFloat(fontSlider.value)
        textLabel.font = textLabel.font.withSize(fontSize)
    }
    
    
    @IBAction func updateCaps(_ sender: UISwitch) {
        //I copied the
        if capsSwitch.isOn{
            textLabel.text = textLabel.text?.uppercased()
        }
        else{
            textLabel.text = textLabel.text?.lowercased()
        }
    }
    
    
    @IBAction func changeColor(_ sender: Any) {
        switch colorSegCont.selectedSegmentIndex
        {
        case 0:
            textLabel.textColor = UIColor.black
        case 1:
            textLabel.textColor = UIColor.blue
        default:
            break
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


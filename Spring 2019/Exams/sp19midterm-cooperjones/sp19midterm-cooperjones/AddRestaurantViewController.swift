//
//  AddRestaurantViewController.swift
//  sp19midterm-cooperjones
//
//  Created by Cooper Jones on 3/25/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import UIKit

class AddRestaurantViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    
    var newName = String()
    var newURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            //only add a country if there is text in the textfield
            if nameField.text?.isEmpty == false{
                newName=nameField.text!
            }
            if urlField.text?.isEmpty == false{
                newURL=urlField.text!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  ViewController.swift
//  cats_or_dogs
//
//  Created by Cooper Jones on 9/4/18.
//  Copyright © 2018 Cooper Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var labelOutput: UILabel!
    
    @IBAction func chooseArt(_ sender: UIButton) {
        if sender.tag == 1 {
            displayImage.image = UIImage(named: "cat")
            labelOutput.text = "Cats are the Best!"
        }
        else if sender.tag == 2 {
            displayImage.image = UIImage(named: "pup")
            labelOutput.text = "Dogs are the best!"
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


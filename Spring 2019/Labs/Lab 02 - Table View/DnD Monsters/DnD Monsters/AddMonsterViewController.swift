//
//  AddMonsterViewController.swift
//  DnD Monsters
//
//  Created by Cooper Jones on 2/20/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import UIKit

class AddMonsterViewController: UIViewController {
    
    var newMonster:MonsterDataModel!
    
    @IBOutlet weak var monsterName: UITextField!
    @IBOutlet weak var str: UITextField!
    @IBOutlet weak var dex: UITextField!
    @IBOutlet weak var con: UITextField!
    @IBOutlet weak var int: UITextField!
    @IBOutlet weak var wis: UITextField!
    @IBOutlet weak var cha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            //only add a country if there is text in the textfield
//            if countryTextfield.text?.isEmpty == false{
//                addedCountry=countryTextfield.text!
//            }
            if monsterName.text?.isEmpty == false{
                newMonster = MonsterDataModel(name:monsterName.text!, str:str.text!, dex:dex.text!, con:con.text!, int:int.text!, wis:wis.text!, cha:cha.text!)
            }
        }
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

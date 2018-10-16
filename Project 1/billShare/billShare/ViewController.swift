//
//  ViewController.swift
//  billShare
//
//  Created by Cooper Jones on 10/15/18.
//  Copyright © 2018 Cooper Jones. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {
    
    let filename = "bills.plist"
    var billArray: [Bill] = []
    
    @IBOutlet weak var billStack: UIStackView!
    
    @IBOutlet weak var monthYear: UILabel!
    @IBOutlet weak var totalDue: UILabel!
    
    
    func dataFileURL(_ filename:String) -> URL?{
        //returns an array of URLs for the document directory in the user's home directory
        let urls = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        var url : URL?
        //append the filename to the first item in the array which is the document directory
        url = urls.first?.appendingPathComponent(filename)
        //return the URL of the data file or nil if doesnt exist
        return url
    }
    
    
    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        displayBills()
        
    }
    
    func displayBills(){
        var total = 0.00
        for view in billStack.arrangedSubviews{
            //deletes all of the bills so it can put them in again
            billStack.removeArrangedSubview(view)
            view.isHidden = true
        }
        for bill in billArray{
            total += bill.amount!
            
            let newBillDisp = UIStackView()
            newBillDisp.distribution = .fillEqually
            billStack.addArrangedSubview(newBillDisp)

            let billName = UILabel()
            billName.textAlignment = NSTextAlignment.left
        
            billName.text = bill.name
            newBillDisp.addArrangedSubview(billName)

            let billDate = UILabel()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd"
            billDate.text = formatter.string(from: bill.dueDate!)
            billDate.textAlignment = NSTextAlignment.center
            newBillDisp.addArrangedSubview(billDate)

            let billAmount = UILabel()
            billAmount.text = "$"+String(format:"%.2f",bill.amount!)
            billAmount.textAlignment = NSTextAlignment.right
            newBillDisp.addArrangedSubview(billAmount)
        }
        totalDue.text = "$"+String(format:"%.2f",total)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        monthYear.text = formatter.string(from: Date())
        
        
    }

    override func viewDidLoad() {
        //url of data file
        let fileURL = dataFileURL(filename)
        
        //if the data file exists use it
        if FileManager.default.fileExists(atPath: (fileURL?.path)!){
            do{
                //creates array of bill objects
                if let billsFromPlist = try NSArray(contentsOf: fileURL!, error: ()) as? [Bill] {
                    for bill in billsFromPlist {
                        billArray.append(bill)
                    }
                }
                
                //create an instance of PropertyListDecoder
            }
            catch{
                print("no file")
            }
        }
        else{
            print("file does not exist")
        }
//        //application instance
        let app = UIApplication.shared
//        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(_:)), name: Notification.Name.UIApplicationWillResignActive, object: app)
        
        displayBills()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //called when the UIApplicationWillResignActiveNotification notification is posted
    //all notification methods take a single NSNotification instance as their argument
    @objc func applicationWillResignActive(_ notification: Notification){
        //url of data file
        let fileURL = dataFileURL(filename)
        //create an instance of PropertyListEncoder
        let encoder = PropertyListEncoder()
        //set format type to xml
        encoder.outputFormat = .xml
        do {
            //encode the data using the structure of the bill class
            let nsBillArray = NSArray(array: billArray)
            try nsBillArray.write(to:fileURL!)
        } catch {
            print("write error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


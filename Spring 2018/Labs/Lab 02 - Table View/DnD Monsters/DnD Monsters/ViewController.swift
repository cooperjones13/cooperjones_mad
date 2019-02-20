//
//  ViewController.swift
//  DnD Monsters
//
//  Created by Cooper Jones on 2/19/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    var monsterNamesList = [String]()
    var monsterData = MonsterDataModelController()
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        monsterData.loadData()
        monsterNamesList=monsterData.getMonsterNames()
        navigationController?.navigationBar.prefersLargeTitles = true
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Monsters"
        
        //search results
        let resultsController = SearchResultsController() //create an instance of our SearchResultsController class
        resultsController.monsterData =  monsterData//set the allwords property to our words array
        searchController = UISearchController(searchResultsController:
        resultsController) //initialize our search controller with the resultsController when it has search results to display
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search term"
        //place holder text
        searchController.searchBar.sizeToFit() //sets appropriate size forthe search bar
        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
        searchController.searchResultsUpdater = resultsController //sets the instance to update search results
        
        //application instance
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector:
            #selector(ViewController.applicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: app)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monsterNamesList.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "MonsterIdentifier", for: indexPath)
        cell.textLabel?.text = monsterNamesList[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsegue" {
            let detailVC = segue.destination as! DetailViewController
            let indexPath = tableView.indexPath(for: sender as!
                UITableViewCell)!
            //sets the data for the destination controller
            detailVC.title = monsterNamesList[indexPath.row]
            detailVC.monsterData = monsterData
            detailVC.selectedMonster = indexPath.row
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt
        indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the country from the array
            monsterNamesList.remove(at: indexPath.row)
            //Delete from the data model instance
            monsterData.deleteMonster(monsterIndex: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt
        indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt
        fromIndexPath: IndexPath, to: IndexPath) {
        let fromRow = fromIndexPath.row //row being moved from
        let toRow = to.row //row being moved to
        let moveMonster = monsterData.getMonster(index: fromRow) //country being moved
        //swap positions in array
        monsterNamesList.swapAt(fromRow, toRow)
        //move in data model instance
        monsterData.deleteMonster(monsterIndex: fromRow)
        monsterData.addMonster(newMonster: moveMonster, newIndex: toRow)
        tableView.reloadData()
    }
    
    @objc func applicationWillResignActive(_ notification: NSNotification){
        monsterData.writeData()
    }

    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let source = segue.source as! AddMonsterViewController
            //only add a country if there is text in the textfield
            if (source.newMonster != nil){
                //add country to our data model instance
                monsterData.addMonster(newMonster: source.newMonster, newIndex: monsterData.getMonsterNames().count)
                //add country to the array
                monsterNamesList.append(source.newMonster.monsterName)
                tableView.reloadData()
            }
        }
    }
}


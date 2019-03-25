//
//  MasterViewController.swift
//  sp19midterm-cooperjones
//
//  Created by Cooper Jones on 3/25/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var restaurants = [String]()
    var restaurantData = RestaurantDataModelController()
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantData.loadData()
        restaurants = restaurantData.getRestaurants()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        let resultsController = SearchResultsController() //create an instance of our SearchResultsController class
        resultsController.restaurantData = restaurantData//set the allwords property to our words array
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
            #selector(MasterViewController.applicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: app)
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let url = restaurantData.getURL(index: indexPath.row)
                let name = restaurants[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = url
                controller.title = name
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath)

        let restaurant = restaurants[indexPath.row]
        cell.textLabel!.text = restaurant
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            restaurants.remove(at: indexPath.row)
            restaurantData.deleteRestaurant(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let source = segue.source as! AddRestaurantViewController
            if ((source.newName.isEmpty) == false && (source.newURL.isEmpty) == false){
                //add country to our data model instance
                restaurantData.addRestaurant(name: source.newName, url: source.newURL)
                //add country to the array
                restaurants.append(source.newName)
                tableView.reloadData()
                
            }
        }
    }

    @objc func applicationWillResignActive(_ notification: NSNotification){
        restaurantData.writeData()
    }

}


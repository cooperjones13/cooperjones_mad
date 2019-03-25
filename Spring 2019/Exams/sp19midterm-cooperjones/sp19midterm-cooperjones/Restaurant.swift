//
//  Restaurant.swift
//  sp19midterm-cooperjones
//
//  Created by Cooper Jones on 3/25/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import Foundation

struct Restaurant: Codable{
    let name : String
    let url : String
}

class RestaurantDataModelController{
    let datafilename = "data.plist"
    var allData = [Restaurant]()
    let fileName = "restaurants"
    
    func loadData(){
        let pathURL:URL?
        // URL for our plist
        let dataFileURL = getDataFile(datafile: datafilename)
        print(dataFileURL)
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: dataFileURL.path){
            pathURL = dataFileURL
        }
        else {
            // URL for our plist
            pathURL = Bundle.main.url(forResource: fileName, withExtension:
                "plist")
        }
        let plistdecoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: pathURL!)
            //decodes the property list
            allData = try
                plistdecoder.decode([Restaurant].self, from: data)
        } catch {
            // handle error
            print(error)
        }
    }
    
    func getRestaurant(index:Int) -> Restaurant {
        return allData[index]
    }
    
    func getRestaurants() -> [String]{
        var restaurants = [String]()
        for restaurant in allData{
            restaurants.append(restaurant.name)
        }
        return restaurants
    }
    
    func getURL(index:Int) -> String {
        return allData[index].url
    }
    
    func deleteRestaurant(index:Int){
        allData.remove(at: index)
    }
    
    func addRestaurant(name: String, url: String){
        let newRestaurant = Restaurant(name: name, url: url)
        allData.append(newRestaurant)
        
    }
    
    func getDataFile(datafile: String) -> URL {
        //get path for data file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //documents directory
        print(docDir)
        // URL for our plist
        return docDir.appendingPathComponent(datafile)
    }
    
    func writeData(){
        // URL for our plist
        let dataFileURL = getDataFile(datafile: datafilename)
        print(dataFileURL)
        //creates a property list decoder object
        let plistencoder = PropertyListEncoder()
        plistencoder.outputFormat = .xml
        do {
            let data = try plistencoder.encode(allData.self)
            try data.write(to: dataFileURL)
        } catch {
            // handle error
            print(error)
        }
    }
}

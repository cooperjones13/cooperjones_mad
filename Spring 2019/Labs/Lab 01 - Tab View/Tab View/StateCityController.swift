//
//  StateCityController.swift
//  Tab View
//
//  Created by Cooper Jones on 2/5/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import Foundation

class StateCityController{
    var allData = [StateCity]()
    let filename = "StateCity"
    
    func loadData(){
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist"){
            let plistdecoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: pathURL)
                //decodes property list
                allData = try plistdecoder.decode([StateCity].self, from: data)
            } catch {
                print(error)
            }
        }
        
    }

    func getStates() -> [String]{
        var states = [String]()
        for state in allData{
            states.append(state.state)
        }
        return states
    }
    
    func getCities(index:Int) -> [String]{
        return allData[index].cities
    }
}

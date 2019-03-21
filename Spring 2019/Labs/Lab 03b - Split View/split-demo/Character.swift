//
//  Character.swift
//  split-demo
//
//  Created by Cooper Jones on 2/28/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import Foundation

struct Character: Decodable{
    let name : String
    let url : String
}

class CharacterDataModelController{
    var allData = [Character]()
    let fileName = "starwars"
    func loadData(){
        if let pathURL = Bundle.main.url(forResource: fileName,
                                         withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                allData = try plistdecoder.decode([Character].self, from:
                    data)
            } catch {
                // handle error
                print(error)
            }
        }
    }
    func getCharacters() -> [String]{
        var characters = [String]()
        for character in allData{
            characters.append(character.name)
        }
        return characters
    }
    func getURL(index:Int) -> String {
        return allData[index].url
    }
}

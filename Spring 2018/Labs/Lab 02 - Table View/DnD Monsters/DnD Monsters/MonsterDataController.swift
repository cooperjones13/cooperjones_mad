//
//  MonsterDataController.swift
//  DnD Monsters
//
//  Created by Cooper Jones on 2/19/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import Foundation

struct MonsterDataModel: Codable{
    var monsterName: String
    var monsterStats: [String]
}

class MonsterDataModelController {
    var allData = [MonsterDataModel]()
    let fileName = "Monsters"
    func loadData(){
        if let pathURL = Bundle.main.url(forResource: fileName,
                                         withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                allData = try
                    plistdecoder.decode([MonsterDataModel].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
    }
    func getMonsterNames() -> [String]{
        var monsterNames = [String]()
        for item in allData{
            monsterNames.append(item.monsterName)
        }
        return monsterNames
    }
    
    func getMonster(index: Int) -> MonsterDataModel{
        return allData[index]
    }
    
    func getMonsterStats(index:Int) -> [String] {
        return allData[index].monsterStats
    }
    func addMonster(newMonster:MonsterDataModel, newIndex: Int){
        allData.insert(newMonster, at: newIndex)
    }
    func deleteMonster(monsterIndex: Int){
        allData.remove(at: monsterIndex)
    }
}

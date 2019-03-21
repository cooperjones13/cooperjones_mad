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
    
    public init(name: String, str: String, dex: String, con: String, int: String, wis: String,cha: String){
        monsterStats = ["STR: " + str, "DEX: " + dex, "CON: " + con, "INT: " + int, "WIS: " + wis, "CHA: " + cha]
        monsterName = name
    }
}

class MonsterDataModelController {
    var allData = [MonsterDataModel]()
    let fileName = "monsterData"
    
    let datafilename = "monsterData.plist"
    
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
            pathURL = Bundle.main.url(forResource: fileName, withExtension: "plist")
        }
        //creates a property list decoder object
        let plistdecoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: pathURL!)
            //decodes the property list
            allData = try plistdecoder.decode([MonsterDataModel].self, from: data)
        } catch {
            // handle error
            print(error)
        }
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

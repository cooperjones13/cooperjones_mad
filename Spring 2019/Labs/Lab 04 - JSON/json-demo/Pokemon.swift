//
//  Pokemon.swift
//  json-demo
//
//  Created by Cooper Jones on 3/6/19.
//  Copyright © 2019 Cooper Jones. All rights reserved.
//

import Foundation

struct PokemonInfo: Decodable{
    let name: String
    let id: Int
}

struct Pokemon: Decodable{
    let name:String
    let url:String
}

struct PokemonData: Decodable {
    var results = [Pokemon]()
}

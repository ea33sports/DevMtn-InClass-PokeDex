//
//  Pokemon.swift
//  PokeDex
//
//  Created by Eric Andersen on 9/4/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

// Name
// Abilities
// ID
// Image

struct Pokemon: Decodable {
    
    let name: String
    let abilities: [AbilitiesDictionary]
    let id: Int
    let spritesDictionary: SpritesDictionary
    
    private enum CodingKeys: String, CodingKey {
        case abilities
        case name
        case id
        case spritesDictionary = "sprites"
    }
    
    var abilitiesName: [String] {
        return abilities.compactMap({$0.ability.name})
    }
    
    struct AbilitiesDictionary: Decodable {
        
        let ability: Ability
        
        struct Ability: Decodable {
            
            let name: String
        }
    }
}





struct SpritesDictionary: Decodable {
    
    let image: URL?
    
    // This enum is for the keys that match the JSON so we can have better naming convention
    private enum CodingKeys: String, CodingKey {
        case image = "front_default"
    }
}

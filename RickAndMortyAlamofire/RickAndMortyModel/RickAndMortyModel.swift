//
//  RickAndMortyModel.swift
//  RickAndMortyAlamofire
//
//  Created by Roman on 20.01.2022.
//

import Foundation
import Alamofire

struct RickAndMorty: Decodable {
    let results: [Characters]?
}

struct Characters: Decodable{
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let image: String?
    
    init(characterData: [String: Any]) {
        name = characterData["name"] as? String
        status = characterData["status"] as? String
        species = characterData["species"] as? String
        type = characterData["type"] as? String
        gender = characterData["gender"] as? String
        image = characterData["image"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Characters] {
        guard let rickData = value as? [String: Any] else { return [] }
        guard let results = rickData["results"] as? [[String: Any]] else { return [] }
        
        var characters = [Characters]()
        
        for result in results {
            let character = Characters(characterData: result)
            characters.append(character)
        }
        return characters
    }
}


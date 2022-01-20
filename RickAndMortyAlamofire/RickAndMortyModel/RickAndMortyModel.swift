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
    
}



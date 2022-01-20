//
//  NetworkManager.swift
//  RickAndMortyAlamofire
//
//  Created by Roman on 20.01.2022.
//

import Foundation
import Alamofire


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetchData(_ url: String, completion: @escaping(Result<[Characters], NetworkError>) -> Void) {
    AF.request(url)
        .validate()
        .responseJSON { dataResponse in
            switch dataResponse.result {
                
            case .success(let value):
                let characters = Characters.getCharacters(from: value)
                completion(.success(characters))
            case .failure:
                completion(.failure(.decodingError))
            }
        }
}
    
}

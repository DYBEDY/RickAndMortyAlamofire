//
//  MainViewController.swift
//  RickAndMortyAlamofire
//
//  Created by Roman on 20.01.2022.
//
import UIKit
import Alamofire

class MainViewController: UITableViewController {
    
    private var characters: [Characters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 160
        fetchDataWithAlamofire()
    }

// MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rick", for: indexPath) as! RickCell

        let character = characters[indexPath.row]
        cell.configure(with: character)

        return cell

}
  
    private func fetchDataWithAlamofire() {
        AF.request("https://rickandmortyapi.com/api/character", method: .get)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                    
                case .success(let value):
                    print(value)
                    guard let rickData = value as? [String: Any] else { return }
                    guard let results = rickData["results"] as? [[String: Any]] else { return }
                    
                    for result in results {
                        let person = Characters(
                            name: result["name"] as? String,
                            status: result["status"] as? String,
                            species: result["species"] as? String,
                            type: result["type"] as? String,
                            gender: result["gender"] as? String,
                            image: result["image"] as? String
                        )
                        self.characters.append(person)
                      
                    }
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print(error )
                }
            }
    }
 

}


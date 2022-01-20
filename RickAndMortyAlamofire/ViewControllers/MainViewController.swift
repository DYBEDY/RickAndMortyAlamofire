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
        NetworkManager.shared.fetchData("https://rickandmortyapi.com/api/character") { result in
            switch result {
            
            case .success(let characters):
                self.characters = characters
                self.tableView.reloadData()
            case .failure(let error):
                    print(error)
            }
        }
    }
 

}


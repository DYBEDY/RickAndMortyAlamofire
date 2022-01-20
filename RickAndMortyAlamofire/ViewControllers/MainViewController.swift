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
    private var filteredCharacters: [Characters] = []
    private var searchBarInEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarInEmpty
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 160
        fetchDataWithAlamofire()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search character"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

// MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCharacters.count
        }
       return  characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rick", for: indexPath) as! RickCell
        
        var character: Characters
        
        if isFiltering {
            character = filteredCharacters[indexPath.row]
        } else {
            character = characters[indexPath.row]
        }
        
        
        cell.configure(with: character)

        return cell

}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    
// MARK: - Network
extension MainViewController {
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



// MARK: - Search Controller

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCharacters = characters.filter({ (character: Characters) -> Bool in
            return character.name?.lowercased().contains(searchText.lowercased()) ?? false
        })
        tableView.reloadData()
    }
}


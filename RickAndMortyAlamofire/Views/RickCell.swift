//
//  RickCell.swift
//  RickAndMortyAlamofire
//
//  Created by Roman on 20.01.2022.
//

import UIKit
import Alamofire

class RickCell: UITableViewCell {
    @IBOutlet var imageOfCharacter: UIImageView! {
        didSet {
            imageOfCharacter.contentMode = .scaleAspectFit
            imageOfCharacter.clipsToBounds = true
            imageOfCharacter.layer.cornerRadius = imageOfCharacter.frame.height / 2
            imageOfCharacter.backgroundColor = .white
        }
    }
    @IBOutlet var nameOfCharacter: UILabel!
    @IBOutlet var typeOfCharacter: UILabel!
    
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    
    
    func configure(with person: Characters?) {
        nameOfCharacter.text = person?.name
        typeOfCharacter.text = "Type: \(person?.type ?? "")"
           genderLabel.text = person?.gender
           speciesLabel.text = person?.species
           statusLabel.text = person?.status
           
           
           DispatchQueue.global().async {
               guard let url = URL(string: person?.image ?? "" ) else { return }
               guard let imageData = try? Data(contentsOf: url) else { return }
               
               DispatchQueue.main.async {
                   self.imageOfCharacter.image = UIImage(data: imageData)
               }
               
           }
       }

}

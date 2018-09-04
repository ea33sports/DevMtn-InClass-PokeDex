//
//  PokemonSearchViewController.swift
//  PokeDex
//
//  Created by Eric Andersen on 9/4/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        setUPUI()
    }
    
    
    func setUPUI() {
        view.addVerticalGradientLayer(topColor: #colorLiteral(red: 0.6857154188, green: 0.6857154188, blue: 0.6857154188, alpha: 0.502729024), bottomColor: #colorLiteral(red: 0.3936191307, green: 0.3936191307, blue: 0.3936191307, alpha: 0.5))
        pokemonImageView.layer.borderColor = UIColor.blue.cgColor
        pokemonImageView.layer.borderWidth = 1.5
        pokemonImageView.layer.cornerRadius = 5
        pokemonImageView.layer.shadowOffset = CGSize(width: 30, height: 40)
        pokemonImageView.layer.shadowColor = #colorLiteral(red: 0.1822255711, green: 0.1822255711, blue: 0.1822255711, alpha: 0.802145762)
        pokemonImageView.layer.shadowRadius = 3
        pokemonImageView.layer.shadowOpacity = 1
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonText = searchBar.text?.lowercased() else { return }
        PokemonController.shared.fetchPokemon(by: pokemonText) { (pokemon) in
            guard let unwrappedPokemon = pokemon else { self.presentAlert(); return }
            DispatchQueue.main.async {
                self.nameLabel.text = unwrappedPokemon.name
                self.idLabel.text = "\(String(describing: unwrappedPokemon.id))"
                self.abilitiesLabel.text = "Abilities: \(unwrappedPokemon.abilitiesName.joined(separator: ", "))"
            }
            PokemonController.shared.fetchImage(pokemon: unwrappedPokemon, completion: { (image) in
                if image != nil {
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                    }
                } else {
                    self.presentAlert()
                }
            })
        }
        
        // dismisses the keyboard
        searchBar.resignFirstResponder()
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "This poky doesn't have an image", message: "Aweee 🤢", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.present(alert, animated: true, completion: nil)
    }
}


extension UIView {
    
    /*
     Adds a vertical gradient layer with two **UIColors** to the **UIView**.
     - Parameter topColor: The top **UIColor**.
     - Parameter bottomColor: The bottom **UIColor**.
     */
    
    func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            topColor.cgColor,
            bottomColor.cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}

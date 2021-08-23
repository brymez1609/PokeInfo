//
//  PokedexDetailViewController.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/22/21.
//

import UIKit

class PokedexDetailViewController: UIViewController {
    var idPokemon = "1"
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var firstGamePokemonImageView: UIImageView!
    @IBOutlet weak var secondGamePokemonImageView: UIImageView!
    @IBOutlet weak var thirdGamePokemonImageView: UIImageView!
    @IBOutlet weak var numberPokedex: UILabel!
    @IBOutlet weak var heightDescription: UILabel!
    @IBOutlet weak var weightDescription: UILabel!
    @IBOutlet weak var typeDescription: UILabel!
    @IBOutlet weak var movesDecription: UILabel!
    @IBOutlet weak var artworkImage: UIImageView!
    weak var viewModel = PokedexViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }
    
    func fillData() {
        viewModel?.getPokemon(id: idPokemon, handler: { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    guard let pokemon = self.viewModel?.pokemon else {
                        return
                    }
                    self.pokemonName.text = pokemon.name.capitalized
                    self.firstGamePokemonImageView.downloaded(from: API.getPokemonsImagesUrl(game: "diamond-pearl", id: self.idPokemon))
                    self.secondGamePokemonImageView.downloaded(from: API.getPokemonsImagesUrl(game: "heartgold-soulsilver", id: self.idPokemon))
                    self.thirdGamePokemonImageView.downloaded(from: API.getPokemonsImagesUrl(game: "platinum", id: self.idPokemon))
                    self.numberPokedex.text = "Pokedex #: \(self.idPokemon)"
                    self.heightDescription.text = String(pokemon.height)
                    self.weightDescription.text = String(pokemon.weight)
                    var typeString = ""
                    var moves = ""
                    pokemon.types.enumerated().forEach { (index,element) in
                        typeString.append(element.type.name.capitalized+", ")
                    }
                    for (index, move) in pokemon.moves.enumerated() {
                        if index > 3 {
                            break
                        }
                        moves.append(move.move.name.capitalized+", ")
                        
                    }
                    self.typeDescription.text = String(typeString.dropLast(2))
                    self.movesDecription.text = String(moves.dropLast(2))
                    guard let image = pokemon.sprites.other?.officialArtwork.frontDefault else {
                        return
                    }
                    self.artworkImage.downloaded(from: image)
                    
                }
            case .failure(_):
                print("Error getting pokemon")
            }
            
        })
    }

}

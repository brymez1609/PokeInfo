//
//  PokedexViewModel.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/21/21.
//

import Foundation
import SwiftyJSON

class PokedexViewModel {
    static let shared = PokedexViewModel()
    var generation = Generation()
    var pokemon = Pokemon()
    func getPokemons(id: String, handler: @escaping (Result<String, NSError>) -> Void)  {
        API.getPokemonsByGeneration(id:id) { (response, error, statusCode) in
            if error != nil {
                handler(.failure(error ?? NSError()))                
            }
            else {
                self.generation = response as? Generation ?? Generation()
                self.generation.pokemonSpecies = self.generation.pokemonSpecies.sorted{ Int($0.url.components(separatedBy: "-species/")[1].replacingOccurrences(of: "/", with: "")) ?? 0 <  Int($1.url.components(separatedBy: "-species/")[1].replacingOccurrences(of: "/", with: "")) ?? 0}
                handler(.success("Load pokemons successfully"))
                
            }
        }
    }
    
    func getPokemon(id:String, handler: @escaping (Result<String, NSError>) -> Void){
        API.getPokemon(id: id) { (response, error, statusCode) in
            if error != nil {
                handler(.failure(error ?? NSError()))
            }
            else {
                self.pokemon = response as? Pokemon ?? Pokemon()
                handler(.success("Load pokemons successfully"))
            }
        }
    }
}

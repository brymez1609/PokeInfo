//
//  VotedViewModel.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/23/21.
//

import Foundation
import RealmSwift

class VotedViewModel {
    let realm = RealmService.shared
    static let shared = VotedViewModel()
    var userLikeFilter = true
    func savePokemon(id:Int,name:String, saved: Bool, liked:  Bool) {
        let pokemonObject = PokemonRealmObject(name: name, id: id, saved: saved, liked: liked)
        realm.save(object: pokemonObject, update: true)
    }
    
    var localPokemons: [PokemonRealmObject] {
        get {
            guard let pokemons = realm.realm?.objects(PokemonRealmObject.self).filter("liked==\(userLikeFilter)") else {return [PokemonRealmObject()]}
            return Array(pokemons)
        }
        set{}
    }
}

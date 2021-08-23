//
//  API.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/21/21.
//

import Foundation
import SwiftyJSON

public typealias RequestResponseJSON = (
    _ response: Codable?,
    _ error: NSError?,
    _ statusCode: Int?) -> Void

class API {
    static func getPokemonsImagesUrl(game: String, id:String) -> String {
        let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/"+game+"/"+id+".png"
        return url
    }
    static func getPokemonsByGeneration(id: String, handler: @escaping RequestResponseJSON) {
        let endPointString = "https://pokeapi.co/api/v2/generation/"+id
        guard let endPoint = URL(string: endPointString ) else {
            return
        }
        URLSession.shared.generationTask(with: endPoint) { generation, response, error in
            let response = response as? HTTPURLResponse
            handler(generation, error as NSError?, response?.statusCode)
        }.resume()
    }
    static func getPokemon(id:String, handler: @escaping RequestResponseJSON) {
        let endPointString = "https://pokeapi.co/api/v2/pokemon/"+id
        guard let endPoint = URL(string: endPointString ) else {
            return
        }
        URLSession.shared.pokemonInfoTask(with: endPoint) { pokemon, response, error in
            let response = response as? HTTPURLResponse
            handler(pokemon, error as NSError?, response?.statusCode)
        }.resume()
    }
    
}

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func generationTask(with url: URL, completionHandler: @escaping (Generation?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    func pokemonInfoTask(with url: URL, completionHandler: @escaping (Pokemon?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

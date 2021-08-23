//
//  Generation.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/21/21.
//

import Foundation

// MARK: - Generation
class Generation: Codable {
    var id: Int = 0
    var pokemonSpecies: [MainRegion] = []

    enum CodingKeys: String, CodingKey {
        case id
        case pokemonSpecies = "pokemon_species"
    }
    
    
    init() {
        self.id = 0
        self.pokemonSpecies = [MainRegion]()
    }
}

// MARK: - MainRegion
class MainRegion: Codable {
    let name: String
    let url: String
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers




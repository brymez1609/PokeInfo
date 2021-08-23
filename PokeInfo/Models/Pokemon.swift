//
//  Pokemon.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/21/21.
//

import Foundation
import RealmSwift

// MARK: - Pokemon
class Pokemon: Codable {
    let height: Int
    let id: Int
    let moves: [Move]
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int

    
    enum CodingKeys: String, CodingKey {
        case height
        case id
        case moves, name
        case sprites, types, weight
    }
    
    init()  {
        height = 0
        id = 0
        moves = []
        name = ""
        sprites = Sprites()
        types = []
        weight = 0

    }
}



// MARK: - Move
struct Move: Codable {
    let move: MainRegion
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}


// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod, versionGroup: MainRegion

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let other: Other?


    enum CodingKeys: String, CodingKey {
        case other
    }

    init() {
        other = Other()
    }
}



// MARK: - Other
struct Other: Codable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
    
    init()  {
        officialArtwork = OfficialArtwork()
    }
}


// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    init() {
        frontDefault = ""
    }
}


// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: MainRegion
}

// MARK: - PokemonRealmObject
class PokemonRealmObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
        
    }
}

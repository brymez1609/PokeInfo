//
//  RealmMigration.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/23/21.
//

import Foundation
import RealmSwift

class RealmMigrationService {
    
    static func migration() {
        let migrationID = 1
        let config = Realm.Configuration(
            schemaVersion: UInt64(migrationID),
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < migrationID) {
                    var nextID = 2
                    migration.enumerateObjects(ofType: PokemonRealmObject.className()) { oldObject, newObject in
                        newObject!["id"] = nextID
                        nextID += 1
                    }
                }
        })
        Realm.Configuration.defaultConfiguration = config
    }
}

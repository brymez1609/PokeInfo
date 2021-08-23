//
//  RealmService.swift
//  PokeInfo
//
//  Created by Bryan Andres Gomez Hernandez on 8/23/21.
//

import Foundation
import UIKit
import RealmSwift

class RealmService: NSObject {
    static let shared = RealmService()        
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func save<T: Object>(object: T, update: Bool = true) {
        do {
            try realm?.write {
                realm?.add(object, update: .modified)
            }
        } catch {
            post(error: error)
        }
    }
    
    func save<T: Object>(objects: [T], update: Bool = true) {
        do {
            try realm?.write {
                realm?.add(objects, update: .modified)
            }
        } catch {
            post(error: error)
        }
    }
    
    func incrementID<T: Object>(object: T) -> Int {
      return (realm?.objects(T.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func update<T: Object>(object: T?, with dictionary: [String: Any?]) {
        guard let object = object else {
            return
        }
        do {
            try realm?.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error: error)
        }
    }
    
    func delete<T: Object>(object: T) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch {
            post(error: error)
        }
    }
    
    func deleteO<T: Object>(objects: [T]) {
        do {
            try realm?.write {
                realm?.delete(objects)
            }
        } catch {
            post(error: error)
        }
    }
    
    
    func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            post(error: error)
        }
    }
    
    func post(error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name(""), object: error)
        print(error)
    }
}

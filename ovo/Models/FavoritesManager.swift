//
//  FavoritesManager.swift
//  ovo
//
//  Created by iOS on 7/28/15.
//
//

import Foundation

class FavoritesManager {
    var favoritesIdentifiers: Set<Int>{
        let defaults = NSUserDefaults.standardUserDefaults()
        if let favoritos = defaults.arrayForKey("favoritos") as? [Int]{
            return Set<Int>(favoritos)
        }
        return Set<Int>()
    }
    
    func addIdentifier(identifier: Int){
        let defaults = NSUserDefaults.standardUserDefaults()
        var set = self.favoritesIdentifiers
        set.insert(identifier)
        defaults.setObject(Array<Int>(set), forKey: "favoritos")
        defaults.synchronize()
    }
    
    func removeIdentifier(identifier: Int){
        let defaults = NSUserDefaults.standardUserDefaults()
        var set = self.favoritesIdentifiers
        set.remove(identifier)
        defaults.setObject(Array<Int>(set), forKey: "favoritos")
        defaults.synchronize()
    }
}
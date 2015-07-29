//
//  FavoritesManager.swift
//  ovo
//
//  Created by iOS on 7/28/15.
//
//

import Foundation

class FavoritesManager {
    
    static let favoritesChangedNotificationName = "favoritosMudou"
    
    var favoritesIdentifiers: Set<Int>{
//        get{
            let defaults = NSUserDefaults.standardUserDefaults()
            if let favoritos = defaults.arrayForKey("favoritos") as? [Int]{
                return Set<Int>(favoritos)
            }
            return Set<Int>()
//        }
    }
    
    func addIdentifier(identifier: Int){
        let defaults = NSUserDefaults.standardUserDefaults()
        var set = self.favoritesIdentifiers
        set.insert(identifier)
        defaults.setObject(Array<Int>(set), forKey: "favoritos")
        defaults.synchronize()
        self.avisaObservers()
    }
    
    func removeIdentifier(identifier: Int){
        let defaults = NSUserDefaults.standardUserDefaults()
        var set = self.favoritesIdentifiers
        set.remove(identifier)
        defaults.setObject(Array<Int>(set), forKey: "favoritos")
        defaults.synchronize()
        self.avisaObservers()
    }
    
    func toggle(identifier : Int){
        if self.favoritesIdentifiers.contains(identifier){
            self.removeIdentifier(identifier)
        }
        else{
            self.addIdentifier(identifier)
        }
    }
    
    func avisaObservers(){
        let name = self.dynamicType.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(name, object: self)
    }
}
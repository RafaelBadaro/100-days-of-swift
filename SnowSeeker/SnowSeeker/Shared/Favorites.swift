//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Rafael Badaró on 08/09/25.
//

import Foundation
import Observation

@Observable
class Favorites {
    private var resorts: Set<String> = []
    private let key = "Favorites"
    
    init() {
        self.loadResorts()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        UserDefaults.standard.set(Array(resorts), forKey: key)
    }
    
    func loadResorts() {
        if let resortsString = UserDefaults.standard.array(forKey: key) as? [String] {
            self.resorts = Set(resortsString)
        }
    }
}

//
//  DataManager.swift
//  day95-challenge-DiceRoll
//
//  Created by Rafael Badaró on 03/09/25.
//

import Foundation
import Observation

@Observable
class DataManager {
    private let SAVE_PATH = URL.documentsDirectory.appending(path: "SavedGames")
    static let shared = DataManager()
    private(set) var history: [Game] = []
    
    private init() {
        self.loadData()
    }
    
    private func loadData() {
        do {
            let data = try Data(contentsOf: SAVE_PATH)
            self.history = try JSONDecoder().decode([Game].self, from: data)
        } catch {
            
        }
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(history)
            try data.write(to: SAVE_PATH, options: [.atomic, .completeFileProtection])
        } catch {
            
        }
    }
    
    func insertGame(_ game: Game) {
        history.append(game)
        saveData()
    }
    
    func deleteGames(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
        saveData()
    }
    
    func deleteAllGames() {
        history.removeAll()
        saveData()
    }

}

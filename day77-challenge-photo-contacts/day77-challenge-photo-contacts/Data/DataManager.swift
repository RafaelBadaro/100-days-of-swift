//
//  DataManager.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 15/07/25.
//

import Foundation

class DataManager {
    static func load() -> [Contact] {
        do {
            let data = try Data(contentsOf: day77_challenge_photo_contactsApp.SAVE_PATH)
            let contacts = try JSONDecoder().decode([Contact].self, from: data)
            return contacts
        } catch {
            
        }
        
        return []
    }
    
    static func save(contacts: [Contact]) {
        do {
            let data = try JSONEncoder().encode(contacts)
            try data.write(to: day77_challenge_photo_contactsApp.SAVE_PATH, options: [.atomic, .completeFileProtection])
        } catch {
            
        }
    }

}

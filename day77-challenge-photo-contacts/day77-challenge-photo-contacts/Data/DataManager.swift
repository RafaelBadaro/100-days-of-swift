//
//  DataManager.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 15/07/25.
//

import Foundation
import Observation

@Observable
class DataManager {
    private let SAVE_PATH = URL.documentsDirectory.appending(path: "SavedContacts")
    static let shared = DataManager()
    private(set) var contacts: [Contact] = []
    
    private init() {
        self.load()
    }
    
    func load() {
        do {
            let data = try Data(contentsOf: SAVE_PATH)
            self.contacts = try JSONDecoder().decode([Contact].self, from: data)
        } catch {
            
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(contacts)
            try data.write(to: SAVE_PATH, options: [.atomic, .completeFileProtection])
        } catch {
            
        }
    }
    
    func addContact(_ contact: Contact) {
        contacts.append(contact)
        save()
    }
    
    func deleteContact(id: UUID) {
        contacts.removeAll(where: { $0.id == id })
        save()
    }
    
    // Para o Foreach da ContentView
    func deleteContacts(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
        save()
    }
}

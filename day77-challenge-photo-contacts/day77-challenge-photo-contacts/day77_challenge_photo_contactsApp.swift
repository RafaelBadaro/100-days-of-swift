//
//  day77_challenge_photo_contactsApp.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 14/07/25.
//

import SwiftUI

@main
struct day77_challenge_photo_contactsApp: App {
    public static let SAVE_PATH = URL.documentsDirectory.appending(path: "SavedContacts")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

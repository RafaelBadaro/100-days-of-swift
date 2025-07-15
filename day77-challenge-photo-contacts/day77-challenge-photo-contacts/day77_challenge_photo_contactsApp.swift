//
//  day77_challenge_photo_contactsApp.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 14/07/25.
//

import SwiftUI

@main
struct day77_challenge_photo_contactsApp: App {    
    @State private var dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataManager)
        }
    }
}

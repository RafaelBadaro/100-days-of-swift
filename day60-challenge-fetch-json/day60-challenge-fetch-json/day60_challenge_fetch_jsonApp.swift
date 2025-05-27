//
//  day60_challenge_fetch_jsonApp.swift
//  day60-challenge-fetch-json
//
//  Created by Rafael Badaró on 25/05/25.
//

import SwiftUI
import SwiftData

@main
struct day60_challenge_fetch_jsonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}

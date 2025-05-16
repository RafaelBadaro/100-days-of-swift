//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Rafael Badaró on 16/05/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}

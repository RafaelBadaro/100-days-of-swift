//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Rafael Badaró on 01/05/25.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}

//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Rafael Badaró on 05/02/25.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}

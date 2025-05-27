//
//  ContentView.swift
//  day60-challenge-fetch-json
//
//  Created by Rafael Badaró on 25/05/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    private var dataManager = DataManager()
    
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Text(user.name)
                            .font(.headline)
                        Spacer()
                        Text(user.isActive ? "Active" : "Inactive")
                            .foregroundStyle(user.isActive ? .green : .red)
                    }
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                DetailView(user: user)
            }
        }
        .onAppear {
            if users.isEmpty {
                Task {
                    let fetchedUsers = await dataManager.fetchUsers()
                    for fetchedUser in fetchedUsers {
                        modelContext.insert(fetchedUser)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

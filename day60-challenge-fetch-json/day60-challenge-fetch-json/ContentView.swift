//
//  ContentView.swift
//  day60-challenge-fetch-json
//
//  Created by Rafael Badaró on 25/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var dataManager = DataManager()
    
    var body: some View {
        NavigationStack {
            List(dataManager.users) { user in
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
            Task {
                await dataManager.fetchUsers()
            }
        }
    }
}

#Preview {
    ContentView()
}

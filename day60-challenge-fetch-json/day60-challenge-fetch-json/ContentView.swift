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
            List(dataManager.users, id: \.id) { user in
                Text(user.name)
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

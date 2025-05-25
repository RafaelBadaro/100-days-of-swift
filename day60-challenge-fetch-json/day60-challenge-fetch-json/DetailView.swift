//
//  DetailView.swift
//  day60-challenge-fetch-json
//
//  Created by Rafael Badaró on 25/05/25.
//

import SwiftUI

struct DetailView: View {
    let user: User
    var body: some View {
        List {
            Section("Info") {
                Text("Age: \(user.age)")
                Text("Company: \(user.age)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("About: \(user.about)")
                Text("Registered: \(user.registered, format: .dateTime)")

            }
            
            Section ("Tags") {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }

            Section ("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name)
    }
}

#Preview {
    DetailView(user: User.sampleData[0])
}

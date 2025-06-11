//
//  ContentView.swift
//  BucketList
//
//  Created by Rafael Badaró on 11/06/25.
//

import SwiftUI

struct User: Comparable, Identifiable {
    let id = UUID()
    var firstname: String
    var lastName: String
    
    // Sim a func chama "<"
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    
    let users = [
        User(firstname: "Arnold", lastName: "Rimmer"),
        User(firstname: "Kristine", lastName: "Kochanski"),
        User(firstname: "David", lastName: "Lister"),
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstname)")
        }
    }
}

#Preview {
    ContentView()
}

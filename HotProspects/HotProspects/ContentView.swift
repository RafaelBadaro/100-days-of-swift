//
//  ContentView.swift
//  HotProspects
//
//  Created by Rafael Badaró on 24/07/25.
//

import SwiftUI

struct ContentView: View {
    let users = ["User 1", "User 2"]
    @State private var selection = Set<String>()
    
    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        
        if !selection.isEmpty {
            Text("You selected \(selection.formatted())")
        }
        
        EditButton()
    }
}

#Preview {
    ContentView()
}

/**
 Day 79
 
 Aula 3:
 
 
 Aula 2:
 
 
 
 
 
 
 
 
 struct ContentView: View {
     let users = ["User 1", "User 2"]
     @State private var selection: String?
     
     var body: some View {
         List(users, id: \.self, selection: $selection) { user in
             Text(user)
         }
         
         if let selection {
             Text("You selected \(selection)")
         }
     }
 }
 
 
 
 */

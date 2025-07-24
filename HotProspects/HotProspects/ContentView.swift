//
//  ContentView.swift
//  HotProspects
//
//  Created by Rafael Badaró on 24/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "One"
    
    var body: some View {
        // Dica: a TabView prefere ser a "parent" view e as views dentro dela com a NavigationStack as necessary
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                    Label("One", systemImage: "star")
            }.tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
            }.tag("Two")
        }
    }
}

#Preview {
    ContentView()
}

/**
 
 
 
 
 
 
 
 
 
 Day 79
 
 Aula 3:
 struct ContentView: View {
     @State private var selectedTab = "One"
     
     var body: some View {
         // Dica: a TabView prefere ser a "parent" view e as views dentro dela com a NavigationStack as necessary
         TabView(selection: $selectedTab) {
             Button("Show Tab 2") {
                 selectedTab = "Two"
             }
             .tabItem {
                     Label("One", systemImage: "star")
             }.tag("One")
             
             Text("Tab 2")
                 .tabItem {
                     Label("Two", systemImage: "circle")
             }.tag("Two")
         }
     }
 }
 
 --------
 Aula 2:
 
 
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

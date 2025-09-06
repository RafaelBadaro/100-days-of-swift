//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rafael Badaró on 06/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    let allNames = ["Soup", "Tomato", "Abacaxi"]
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { name in
                name.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }
}

#Preview {
    ContentView()
}

/**
 
 ------
 Day 96 - aula 5
 
 
 
 ------
 Day 96 - aula 4
 
 struct ContentView: View {
     @State private var searchText = ""
     let allNames = ["Soup", "Tomato", "Abacaxi"]
     
     var filteredNames: [String] {
         if searchText.isEmpty {
             allNames
         } else {
             allNames.filter { name in
                 name.localizedStandardContains(searchText)
             }
         }
     }
     
     var body: some View {
         NavigationStack {
             List(filteredNames, id: \.self) { name in
                 Text(name)
             }
             .searchable(text: $searchText, prompt: "Look for something")
             .navigationTitle("Searching")
         }
     }
 }
 
 
 ------
 Day 96 - aula 3
 
 struct UserView: View {
     var body: some View {
         Group{
             Text("1")
             Text("2")
             Text("3")
         }
         .font(.title)
     }
 }

 struct ContentView: View {
     @State private var layoutVertically = false
     
     var body: some View {
         Button {
             layoutVertically.toggle()
         } label: {
             if layoutVertically {
                 VStack {
                     UserView()
                 }
             } else {
                 HStack {
                     UserView()
                 }
             }
         }
        
     }
 }
 
 struct ContentView: View {
     @Environment(\.horizontalSizeClass) var horizontalSizeClass
     
     var body: some View {
         if horizontalSizeClass == .compact {
             VStack(content: UserView.init)
         } else {
             HStack(content: UserView.init)
         }
     }
 }
 
 
 struct ContentView: View {
     var body: some View {
         ViewThatFits {
             Rectangle()
                 .frame(width: 500, height: 200)
             
             Circle()
                 .frame(width: 200, height: 200)
         }
     }
 }

 
 
 
 
 
 ------
 Day 96 - aula 2
 
 struct User: Identifiable {
     var id = "Test"
 }
 
 struct ContentView: View {
     @State private var selectedUser: User? = nil
     
     var body: some View {
         Button("Tap me") {
             selectedUser = User()
         }
         .sheet(item: $selectedUser) { unwrappedUser in
             Text(unwrappedUser.id)
         }
     }
 }
 
 struct ContentView: View {
     @State private var selectedUser: User? = nil
     @State private var isShowingAlert = false
     
     var body: some View {
         Button("Tap me") {
             selectedUser = User()
             isShowingAlert = true
         }
         .alert("Hello", isPresented: $isShowingAlert, presenting: selectedUser) { unwrappedUser in
             Text(unwrappedUser.id)
         }
     }
 }
 
 
 
 */

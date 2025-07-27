//
//  ContentView.swift
//  HotProspects
//
//  Created by Rafael Badaró on 24/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Text("Teste")
                .swipeActions {
                    Button("Send message", systemImage: "minus.circle", role: .destructive) {
                        print("Delete")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pin")
                    }
                    .tint(.orange)
                }
        }
    }
}

#Preview {
    ContentView()
}

/*
 
 --------
 Day 81:
 
 Aula 1:
 
 --------
 Aula 2:
 
 --------
 Aula 3:
 
 
 
 --------
 Day 80:
 
 Aula 1:
 
 struct ContentView: View {
     @State private var output = ""
     
     var body: some View {
         Text(output)
             .task {
                 await fetchReadings()
             }
     }
     
     func fetchReadings() async {
         let fetchTask = Task {
             let url = URL(string: "https://www.hackingwithswift.com/samples/readings.json")!
             let (data, _) = try await URLSession.shared.data(from: url)
             let readings = try JSONDecoder().decode([Double].self, from: data)
              return "Found \(readings.count) readings"
         }
         
         let result = await fetchTask.result
         
 //        do {
 //            output = try result.get()
 //        } catch {
 //            output = "Error: \(error.localizedDescription)"
 //        }
         
         switch result{
         case .success(let str):
             output = str
         case .failure(let error):
             output = "Error: \(error.localizedDescription)"
         }
     }
 }
 
 
 --------
 Aula 2:
 
 struct ContentView: View {
     var body: some View {
         Image(.example)
             .interpolation(.none)
             .resizable()
             .scaledToFit()
             .background(.black)
     }
 }
 
 
 --------
 Aula 3:
 
 struct ContentView: View {
     @State private var background = Color.red
     
     var body: some View {
         VStack {
             Text("Hello World!")
                 .padding()
                 .background(background)
             
             Text("Change Color")
                 .padding()
                 .contextMenu {
                     Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                         background = Color.red
                     }
                     
                     Button("Green") {
                         background = Color.green
                     }
                     
                     Button("Blue") {
                         background = Color.blue
                     }
                 }
         }

     }
 }
 
 
 
 
 
 --------
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

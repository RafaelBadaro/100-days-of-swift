//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rafael Badaró on 06/09/25.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationSplitView {
            List(resorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay (
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
        } detail: {
            WelcomeView()
        }
    }
}

#Preview {
    ContentView()
}

/**
 
 ------
 Day 96 - aula 5
 
 @Observable
 class Player {
     var name = "Anonymous"
     var highScore = 0
 }

 struct HighScoreView: View {
     @Environment(Player.self) var player
     
     var body: some View {
         VStack {
             Text("Your high score: \(player.highScore)")
         }
     }
 }

 struct ContentView: View {
     @State private var player = Player()

     var body: some View {
         VStack {
             Text("Welcome!")
             HighScoreView()
         }
         .environment(player)
     }
 }
 
 
 Usando o @Environment como bindable
 
 struct HighScoreView: View {
     @Environment(Player.self) var player
     
     var body: some View {
         @Bindable var player = player
         Stepper("High score: \(player.highScore)", value: $player.highScore)
     }
 }
 
 
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

//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rafael Badaró on 06/09/25.
//

import SwiftUI

struct ContentView: View {
    enum SortOption: String, CaseIterable, Identifiable {
        case `default` = "Default"
        case alphabetical = "Alphabetical"
        case country = "By Country"
        
        var id: Self { self }
    }
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortOption: SortOption = .default
 
    var filteredResorts: [Resort] {
        var sortedResorts: [Resort] {
            switch sortOption {
            case .default:
                return resorts
            case .alphabetical:
                return resorts.sorted { $0.name < $1.name }
            case .country:
                return resorts.sorted { $0.country < $1.country }
            }
        }
        
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
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
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Sort", selection: $sortOption) {
                            ForEach(SortOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
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

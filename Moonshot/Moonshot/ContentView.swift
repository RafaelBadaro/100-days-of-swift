//
//  ContentView.swift
//  Moonshot
//
//  Created by Rafael Badaró on 19/02/25.
//

import SwiftUI



struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem {
                    Toggle(isOn: $showingGrid) {
                        Text(showingGrid ? "List" : "Grid") // Atualiza o texto com base no estado
                            .font(.headline) // Ajuste de estilo do texto, se necessário
                    }
                    .toggleStyle(.button) // Estilo personalizado (opcional)
                }
            }
            .navigationDestination(for: Mission.self) { mission in
                           MissionView(mission: mission, astronauts: astronauts)

            }

        }
    }
}

#Preview {
    ContentView()
}

struct GridLayout: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var missions: [Mission]
    var astronauts: [String: Astronaut]
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        MissionLabelView(mission: mission)
                    }
//                    NavigationLink {
//                        MissionView(mission: mission,
//                                    astronauts: astronauts)
//                    } label : {
//                        MissionLabelView(mission: mission)
//                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout: View {
    var missions: [Mission]
    var astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                
                ZStack {
                    NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                        EmptyView() // Mantém a navegação funcional, mas sem o chevron
                    }
                    .opacity(0) // Torna invisível, mas ainda funcional
                    
                    MissionLabelView(mission: mission) // A view visível
                }
                .listRowBackground(Color.darkBackground)
                .listRowSeparator(.hidden)
                
                // Codigo de antes, porém com chevron chato na direita, deixando só por referencia
                 /*
                  NavigationLink {
                      MissionView(mission: mission,
                                  astronauts: astronauts)
                  } label : {
                      MissionLabelView(mission: mission)
                  }
                  .listRowBackground(Color.darkBackground)
                  .listRowSeparator(.hidden)
                  */
                
                
            }
        }
        .listStyle(.plain)
    }
}

struct MissionLabelView: View {
    var mission: Mission
    
    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay (
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
}

/*
 
 
 let layout = [
 GridItem(.adaptive(minimum: 80, maximum: 120))
 ]
 
 var body: some View {
 
 ScrollView (.horizontal) {
 LazyHGrid(rows: layout) {
 ForEach(0..<1000){
 Text("Item \($0)")
 }
 }
 }
 
 }
 
 -------------------------------
 
 struct User: Codable {
 let name: String
 let address: Address
 }
 
 struct Address: Codable {
 let street: String
 let city: String
 }
 
 
 Button("Decode JSON") {
 let input = """
 {
 "name": "Taylor Swift",
 "address": {
 "street": "555, avenue",
 "city": "Nashville"
 }
 }
 """
 
 let data = Data(input.utf8)
 let decoder = JSONDecoder()
 
 if let user = try? decoder.decode(User.self, from: data) {
 print(user.address.street)
 }
 }
 
 -------------------------------
 
 NavigationStack {
 List(0..<100) { row in
 NavigationLink("Row \(row)") {
 Text("Detail \(row)")
 }
 }
 .navigationTitle("SwiftUI")
 }
 
 
 NavigationStack {
 NavigationLink {
 Text("Detail View")
 } label: {
 VStack {
 Text("This is the label")
 Text("So is this")
 Image(systemName: "face.smiling")
 }
 .font(.largeTitle)
 }
 .navigationTitle("SwiftUI")
 }
 
 
 -------------------------------
 
 struct CustomText: View {
 let text: String
 
 var body: some View {
 Text(text)
 }
 
 init(text: String) {
 print("Creating a new CustomText: \(text)")
 self.text = text
 }
 }
 
 ScrollView (.horizos   ntal) {
 LazyHStack (spacing: 20) {
 ForEach(0..<100) {
 CustomText(text: "Item \($0)")
 .font(.title)
 }
 }
 }
 
 
 
 -------------------------------
 
 Image(.example)
 .resizable()
 .scaledToFit()
 .containerRelativeFrame(.horizontal) { size, axis in
 size * 0.8
 }
 */

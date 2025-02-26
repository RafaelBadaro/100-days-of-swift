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
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid (columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission,
                                        astronauts: astronauts)
                        } label : {
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
                }
                .padding([.horizontal, .bottom])
                
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
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

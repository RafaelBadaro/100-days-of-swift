//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Rafael Badaró on 09/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
        
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
            
        }
    }
}

#Preview {
    ContentView()
}


/*
 
 struct ContentView: View {
     
     @State private var username = ""
     @State private var email = ""
     
     var disableForm: Bool {
         username.count < 5 || email.count < 5
     }
         
     var body: some View {
         Form {
             Section {
                 TextField("Username", text: $username)
                 TextField("Email", text: $email)
             }
             
             Section {
                 Button("Create account") {
                     print("Creating account...")
                 }
             }
             .disabled(disableForm)
             
         }
     }
 }
 
 ------------------
 
 struct ContentView: View {
         
     var body: some View {
         // Usar o scale voce consegue mudar o tamanho da imagem
         //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
         
         // Usando a imagem em si
 //        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
 //            image
 //                .resizable()
 //                .scaledToFit()
 //        } placeholder: {
 //            //Color.red
 //            ProgressView()
 //        }
 //        .frame(width: 200, height: 200)
         // Usando a phase, adiciona mais um estado, o de "error"
         AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
             if let image = phase.image {
                 image
                     .resizable()
                     .scaledToFit()
             } else if phase.error != nil {
                 Text("There was an error loading the image")
             } else {
                 ProgressView()
             }
         }
         .frame(width: 200, height: 200)
         
     }
 }
 
 
 ------------------
 
 struct Response: Codable {
     var results: [Result]
 }

 struct Result: Codable {
     var trackId: Int
     var trackName: String
     var collectionName: String
 }

 struct ContentView: View {
     
     @State private var results = [Result]()
     
     var body: some View {
         List(results, id: \.trackId) { item in
             VStack(alignment: .leading) {
                 Text(item.trackName)
                     .font(.headline)
                 
                 Text(item.collectionName)
             }
         }
         .task {
             await loadData()
         }
     }
     
     func loadData() async {
         guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song")
         else {
             print("Invalid URL")
             return
         }
         
         do {
             let (data, _) = try await URLSession.shared.data(from: url)
             
             if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                 results = decodedResponse.results
             }
         } catch {
             print("Invalid data")
         }
         
         
     }
 }
 
 */

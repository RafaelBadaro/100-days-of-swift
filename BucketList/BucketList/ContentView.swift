//
//  ContentView.swift
//  BucketList
//
//  Created by Rafael Badaró on 11/06/25.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    
    let locations = [
        Location(name: "Buckingham Palace",
                 coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London",
                 coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        VStack {
            MapReader { proxy in
                Map()
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .global) {
                            print(coordinate)
                        }
                        
                    }
            }
        }
        .padding()
        
        Text("TESTE")
    }
}

#Preview {
    ContentView()
}

/***
 
 Aula 1:
 
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
 
 
 --------
 
 Aula 2:
 
 extension FileManager {
     
     func read (_ fileName: String) -> String {
         let url = URL.documentsDirectory.appendingPathComponent(fileName)
         
         guard let data = try? String(contentsOf: url, encoding: .utf8) else {
             fatalError()
         }
     
         return data
     }
     
     func write(_ fileName: String,_ dataToWrite: Data){
         let url = URL.documentsDirectory.appendingPathComponent(fileName)
         try? dataToWrite.write(to: url, options: [.atomic, .completeFileProtection])
     }
 }

 struct ContentView: View {

     var body: some View {
         Button("Read and Write") {
             let data = Data("Test Message".utf8)
             FileManager.default.write("message.txt", data)
             let input: String = FileManager.default.read("message.txt")
             print(input)
         }
     }
 }
 
 --------
 
 Aula 3:
 
 struct LoadingView: View {
     var body: some View {
         Text("Loading...")
     }
 }

 struct SuccessView: View {
     var body: some View {
         Text("Success!")
     }
 }

 struct FailedView: View {
     var body: some View {
         Text("Failed.")
     }
 }

 struct ContentView: View {
     enum LoadingState {
         case loading, success, failed
     }
     
     @State private var loadingState = LoadingState.loading
     
     var body: some View {
         switch loadingState {
         case .loading:
             LoadingView()
         case .success:
             SuccessView()
         case .failed:
             FailedView()
         }
     }
 }
 
 */

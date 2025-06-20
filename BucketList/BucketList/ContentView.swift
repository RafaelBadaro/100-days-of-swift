//
//  ContentView.swift
//  BucketList
//
//  Created by Rafael Badaró on 11/06/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(center:
                            CLLocationCoordinate2D(latitude: 56, longitude: -3),
                           span:
                            MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )
    
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Annotation(location.name,
                               coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                        // Esse daqui não funcionou
//                            .onLongPressGesture {
//                                selectedPlace = location
//                            }
                        
                            // Adaptação que peguei dos comentarios do video do youtube
                            .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in
                                selectedPlace = location
                            })
                    }
                }
            }
            .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        let newLocation = Location(id: UUID(),
                                                   name: "New Location",
                                                   description: "",
                                                   latitude: coordinate.latitude,
                                                   longitude: coordinate.longitude)
                        locations.append(newLocation)
                    }
                }
            .sheet(item: $selectedPlace) { place in
                EditView(location: place) { newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                }
            }
        }

    }
    
}

#Preview {
    ContentView()
}

/***
 
 Day 68 - Aula 1:
 
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
 
 Day 68 - Aula 2:
 
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
 
 Day 68 - Aula 3:
 
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
 
 Day 69:
 
 import SwiftUI
 import LocalAuthentication

 struct ContentView: View {
     
     @State private var isUnlocked = false
     
     var body: some View {
         VStack {
             if isUnlocked {
                 Text("Unlocked")
             } else {
                 Text("Locked")
             }
         }
         .onAppear(perform: authentitcate)
     }
     
     func authentitcate() {
         let context = LAContext()
         var error: NSError?
         
         if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
             let reason = "We need to unlock your data."
             
             context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                 
                 if success {
                     // ok
                     isUnlocked = true
                 } else {
                    // error
                 }
                 
             }
             
         } else {
              // no biometrics
         }
         
     }
 }
 
 Day 70:
 
 
 
 */

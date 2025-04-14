//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Rafael Badaró on 09/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
   
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)",
                            value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?",
                           isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
                
            }
            .navigationTitle("Cupcake Corner")
            
        }
        
    }
}

#Preview {
    ContentView()
}


/*
 
 
 ------------------
 
 import CoreHaptics
 import SwiftUI

 struct ContentView: View {
     @State private var engine: CHHapticEngine?
     
     var body: some View {
         Button("Play haptic", action: complexSuccess)
             .onAppear(perform: prepareHaptics)
     }
     
     
     func prepareHaptics() {
         guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
         
         do {
             engine = try CHHapticEngine()
             try engine?.start()
         } catch {
             print("Failed to create haptic engine: \(error.localizedDescription)")
         }
     }
     
     func complexSuccess() {
         guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
         
         var events = [CHHapticEvent]()
         
         for i in stride(from: 0, to: 1, by: 0.1) {
             let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
             let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
             let event = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [intensity, sharpness],
                                       relativeTime: i)
             events.append(event)
         }
         
         for i in stride(from: 0, to: 1, by: 0.1) {
             let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
             let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
             let event = CHHapticEvent(eventType: .hapticTransient,
                                       parameters: [intensity, sharpness],
                                       relativeTime: 1 + i)
             events.append(event)
         }
         
         do {
             let pattern = try CHHapticPattern(events: events, parameters: [])
             let player = try engine?.makePlayer(with: pattern)
             try player?.start(atTime: 0)
         } catch {
             print("Failed to play pattern: \(error.localizedDescription)")
         }
         
     }
 }

 
 ------------------
 
 struct ContentView: View {
     @State private var counter = 0
     
     var body: some View {
         Button("Tap count: \(counter)") {
             counter += 1
         }
         .sensoryFeedback(.impact(weight: .heavy, intensity: 1),
                          trigger: counter)
     }
 }
 
 ------------------
 
 @Observable
 class User: Codable {
     // Sem o coding keys: {"_name":"rafael","_$observationRegistrar":{}}
     // Com o coding keys: {"name":"rafael"}
     // Ele faz com que @Observable não printe algo como "_name"
     enum CodingKeys: String, CodingKey {
         case _name = "name"
     }
     var name = "rafael"
 }

 struct ContentView: View {
     var body: some View {
         Button ("Encode", action: encodeUser)
     }
     
     func encodeUser() {
         let data = try! JSONEncoder().encode(User())
         let str = String(decoding: data, as: UTF8.self)
         print(str)
     }
 }
 
 ------------------
 
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

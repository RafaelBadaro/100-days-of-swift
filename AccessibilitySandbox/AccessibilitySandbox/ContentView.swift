//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Rafael Badaró on 30/06/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button tapped!")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kenndy", "JFK"])
    }
    
    
}

#Preview {
    ContentView()
}

/**
 
 
Day 75 - Aula 1:
 
 
 
------------
Day 74 - Aula 3:
 
 struct ContentView: View {
     @State private var value = 10
     
     var body: some View {
         VStack {
             Text("Value: \(value)")
             
             Button("Increment") {
                 value += 1
             }
             
             Button("Decrement") {
                 value -= 1
             }
         }
         .accessibilityElement()
         .accessibilityLabel("Value")
         .accessibilityValue(String(value))
         .accessibilityAdjustableAction { direction in
             switch direction {
             case .increment:
                 value += 1
             case .decrement:
                 value -= 1
             @unknown default:
                 print("Not handled")
             }
         }
         
     }
 }
 
 
------------
Day 74 - Aula 2:
 
 VStack {
     Text("Your score is")
     
     Text("1000")
         .font(.title)
 }
 // o .ignore vem por padrao entao pode ser só:  .accessibilityElement()
 .accessibilityElement(children: .ignore)
 .accessibilityLabel("Your score is 1000")
 
 VStack {
     Text("Your score is")
     
     Text("1000")
         .font(.title)
 }
 .accessibilityElement(children: .combine)
 
 
 Como esconder a leitura do voiceover
 
 Image(decorative: "character")
 
 Image(.character)
     .accessibilityHidden(true)
 
------------
Day 74 - Aula 1:

struct ContentView: View {
    let picures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    var body: some View {
        Button {
            selectedPicture = Int.random(in: 0...3)
        } label: {
            Image(picures[selectedPicture])
                .resizable()
                .scaledToFit()
        }
        .accessibilityLabel(labels[selectedPicture])
        
//        Image(picures[selectedPicture])
//            .resizable()
//            .scaledToFit()
//            .onTapGesture {
//                selectedPicture = Int.random(in: 0...3)
//            }
//            .accessibilityLabel(labels[selectedPicture])
//            .accessibilityAddTraits(.isButton)
//            .accessibilityRemoveTraits(.isImage)
    }
}
*/

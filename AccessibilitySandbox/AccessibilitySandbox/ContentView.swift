//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Rafael Badaró on 30/06/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Your score is")
            
            Text("1000")
                .font(.title)
        }
        .accessibilityElement()
        .accessibilityLabel("Your score is 1000")
        
    }
}

#Preview {
    ContentView()
}

/**
 
 
Aula 3:
 
------------
Aula 2:
 
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
Aula 1:

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

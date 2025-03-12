//
//  ContentView.swift
//  Navigation
//
//  Created by Rafael Badaró on 12/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

#Preview {
    ContentView()
}



/*
 
 // Usando assim o SwiftUI cria a view de dentro, no caso Text, mesmo antes dela ser chamada
 NavigationStack {
     NavigationLink("Tap") {
         Text("Detail View")
     }
 }
 
 */

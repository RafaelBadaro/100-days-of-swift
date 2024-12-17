//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Rafael Badaró on 10/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Color.red
        VStack {
            Color.blue
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

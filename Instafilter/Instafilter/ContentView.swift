//
//  ContentView.swift
//  Instafilter
//
//  Created by Rafael Badaró on 29/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        ContentUnavailableView("No snippets",
//                               systemImage: "swift",
//        description: Text("You don't have any saved snippets yet"))
        ContentUnavailableView {
            Label("No snippets",  systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet")
        } actions: {
            Button("Create snippets") {
                
            }
            .buttonStyle(.borderedProminent)
        }
    }

}

#Preview {
    ContentView()
}

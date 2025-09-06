//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rafael Badaró on 06/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            Text("primary")
        } detail: {
            Text("content")
        }
    }
}

#Preview {
    ContentView() 
}

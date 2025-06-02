//
//  ContentView.swift
//  Instafilter
//
//  Created by Rafael Badaró on 29/05/25.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
//        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!,
//                  subject: Text("Learn Swift here"),
//                  message: Text("Check out the 100 days of SwiftUI"))
//        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
//            Label("Spread the word about Swift", systemImage: "swift")
//        }
        
        let example = Image(.example)
        ShareLink(item: example, preview: SharePreview("Example image", image: example)) {
            Label("Click to share", systemImage: "airplane")
        }
        
    }
    
}

#Preview {
    ContentView()
}

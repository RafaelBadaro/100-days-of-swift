//
//  AstronautView.swift
//  Moonshot
//
//  Created by Rafael Badaró on 26/02/25.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    let astronatus: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return AstronautView(astronaut: astronatus["aldrin"]!)
        .preferredColorScheme(.dark)
}

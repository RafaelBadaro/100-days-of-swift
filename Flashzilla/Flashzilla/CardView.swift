//
//  CardView.swift
//  Flashzilla
//
//  Created by Rafael Badaró on 20/08/25.
//

import SwiftUI

struct CardView: View {
    @State private var isShowingAnser = false
    let card: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isShowingAnser {
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .onTapGesture {
            isShowingAnser.toggle()
        }
    }
}

#Preview {
    CardView(card: .example)
}

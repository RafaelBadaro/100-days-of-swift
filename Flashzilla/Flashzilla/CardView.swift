//
//  CardView.swift
//  Flashzilla
//
//  Created by Rafael Badaró on 20/08/25.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var offset = CGSize.zero
    @State private var isShowingAnser = false
    
    let card: Card
    
    var removal: ((Bool) -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        // Challenge #2: o problema é que ao arrastar para a direita soltar ao voltar pro centro o card fica com a cor vermelha (por um momento beeem breve)
                        // Isso acontece porque setamos o "offset = .zero" no "onEnded"
                        // Quando o offset = .zero, ele zera as duas propriedades que tem no offset (height e width)
                        // E quando o width = 0, ele cai no caso de .red aqui desse .fill
                        //.fill(offset.width > 0 ? .green : .red)
                        // Em portugues: "Se for maior que zero é .green, se for menor OU IGUAL ele é .red
                        // pq "ou igual"? pq só especificamos o .green, para quando width > 0
                        // FIX:
                        .fill(offset.width > 0 ? .green : (offset.width < 0 ? .red : .white))
                        // Colocamos outro ternario que verifica se o width < 0, isso garante que o card será vermelho SÓ se o offset for menor que zero
                        // e caso contrario (ou seja, igual a zero) setamos para .white
                )
                .shadow(radius: 10)
            
            VStack {
                
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnser ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnser {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(
            .degrees(offset.width / 5.0)
        )
        .offset(x: offset.width * 5)
        .opacity(
            2 - Double(abs(offset.width / 50))
        )
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        var isCorrect = false
                        if offset.width > 0 {
                            isCorrect = true
                        }
                        
                        removal?(isCorrect)
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnser.toggle()
        }
        .animation(.bouncy, value: offset)
    }
}

#Preview {
    CardView(card: .example)
}

//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Rafael Badaró on 28/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
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

/**
 
 Day 92 - aula 1
 
 Os modifiers de uma View criam uma nova View
 A ordem para montagem de Layout é tipo assim:
 
 Text("Hello, world!")
    .background(.red)
 
 SwiftUI para ContentView -> "Oi, quanto vc quer de espaço?"
 ContentView -> "Hmm não sei, vou perguntar pro meu filho"
 ContentView para .background(.red) -> "Oi, quando vc quer de espaço?"
 .background(.red):
    Esse cara é layout neutral, ou seja, ele não define um espaço (Cor e Shapes por exemplo são layout netural, se não definir um espaço pra elas, elas ocupam todo o espaço disponivel)
    Por exemplo, quando vc faz só Color.red, ele ocupa a tela inteira
 
 Voltando, .background(.red) para ContentView -> "Não sei quanto de espaço, sou layout neutral, vou perguntar pro meu filho"
 .background(.red) para Text("Hello, world!") -> "Oi, quando vc quer de espaço?"
 Text("Hello, world!") para .background(.red) -> "Hmm sou um texto de tamanho X, com Y letras, usando a fonte padrão, ermm acho que quero bla bla bla"
 .background(.red) para ContentView -> "Eu quero bla bla bla de espaço"
 ContentView para SwiftUI -> "Eu quero bla bla bla de espaço"
 Pronto.
 */

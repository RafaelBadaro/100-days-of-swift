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
 
 Day 92 - aulas 2,3,4
 
 Aula 2 - ele mostrou o alignmentGuide, basicamente ele faz o override do alinhamento
 no ex abaixo, "quando receber o .leading, retornar o .trailing (tem teoria pode ser qualquer coisa)
 
 VStack(alignment: .leading) {
     Text("Hello, world!")
         .alignmentGuide(.leading) { d in d[.trailing] }
     Text("This is a longer line of text")
 }
 
 Aula 3 - acheio meio confuso, mas a memsa ideia da aula 2, ele criou uma extension pra ser um "modelo" de alignment, no caso utiliza o .top
 E depois ele fez o override disso de novo com o .alignmentGuide
 
 extension VerticalAlignment {
     struct MidAccountAndName: AlignmentID {
         static func defaultValue(in context: ViewDimensions) -> CGFloat {
             context[.top]
         }
     }

     static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
 }
 
 HStack(alignment: .midAccountAndName) {
     VStack {
         Text("@twostraws")
             .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
         Image(.paulHudson)
             .resizable()
             .frame(width: 64, height: 64)
     }

     VStack {
         Text("Full name:")
         Text("PAUL HUDSON")
             .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
             .font(.largeTitle)
     }
 }
 
 Aula 4 - Ele mostrou a importancia da ordem dos modifiers utilizando o codigo abaixo:
 
 Text("Hello, world!")
     .background(.red)
     .position(x: 100, y: 100)
 
 Text("Hello, world!")
     .position(x: 100, y: 100)
     .background(.red)

 Text("Hello, world!")
     .offset(x: 100, y: 100)
     .background(.red)
 
 Text("Hello, world!")
     .background(.red)
     .offset(x: 100, y: 100)
 
 
 
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

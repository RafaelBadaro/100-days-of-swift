//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Rafael Badaró on 28/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { number in
                    Text("Number \(number)")
                        .font(.largeTitle)
                        .padding()
                        .background(.red)
                        .frame(width: 200, height: 200)
                        .visualEffect { content, proxy in
                            content
                                .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX / 8),
                                                  axis: (x: 0, y: 1, z:0)
                                )
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    ContentView()
}

/**
 
 Day 93 - aula 4
 
 Baseado no codigo da ultima aula, da pra alterar pra NÃO usar o GeometryReader e usar um novo cara chamado visualEffect, que tambem recebe um proxy
 
 struct ContentView: View {
     var body: some View {
         ScrollView(.horizontal, showsIndicators: false) {
             HStack(spacing: 0) {
                 ForEach(1..<20) { number in
                     Text("Number \(number)")
                         .font(.largeTitle)
                         .padding()
                         .background(.red)
                         .frame(width: 200, height: 200)
                         .visualEffect { content, proxy in
                             content
                                 .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX / 8),
                                                   axis: (x: 0, y: 1, z:0)
                                 )
                         }
                 }
             }
         }
     }
 }
 
 Alem disso adicionando as duas linhas destacadas abaixo, a scrollTargetLayout() na HStack e a scrollTargetBehavior(.viewAligned) na ScrollView
 Temos um efeito que não sei explicar o nome kkkkk MAS ele deixa sempre um item da ScrollView "focado"
 Sem essas linhas, você meio que pode parar a animação de um item no meio do caminho
 
 struct ContentView: View {
     var body: some View {
         ScrollView(.horizontal, showsIndicators: false) {
             HStack(spacing: 0) {
                 ForEach(1..<20) { number in
                     Text("Number \(number)")
                         .font(.largeTitle)
                         .padding()
                         .background(.red)
                         .frame(width: 200, height: 200)
                         .visualEffect { content, proxy in
                             content
                                 .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX / 8),
                                                   axis: (x: 0, y: 1, z:0)
                                 )
                         }
                 }
             }
             .scrollTargetLayout() <--- essa linha
         }
         .scrollTargetBehavior(.viewAligned) <--- essa linha
     }
 }

 

 
 
 -------
 Day 93 - aula 3
 
 Basicamente ele criou efeitos na tela usando o esse rotation3DEffect e o GeometryReader
 
 struct ContentView: View {
     
     var body: some View {
         ScrollView(.horizontal, showsIndicators: false) {
             HStack(spacing: 0) {
                 ForEach(1..<20) { number in
                     GeometryReader { proxy in
                         Text("Number \(number)")
                             .font(.largeTitle)
                             .padding()
                             .background(.red)
                             .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX / 8),
                                               axis: (x: 0, y: 1, z:0)
                             )
                             .frame(width: 200, height: 200)
                     }
                     .frame(width: 200, height: 200)
                 }
             }
         }
     }
 }
 
 struct ContentView: View {
     
     let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
     
     var body: some View {
         GeometryReader { fullView in
             ScrollView {
                 ForEach(0..<50) { index in
                     GeometryReader { proxy in
                         Text("Row #\(index)")
                             .font(.title)
                             .frame(maxWidth: .infinity)
                             .background(colors[index % 7])
                             .rotation3DEffect(
                                 .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5,
                                 axis: (x: 0, y: 1, z:0))
                     }
                     .frame(height: 40)
                 }
             }
             
         }
     }
 }
 
 
 -------
 Day 93 - aula 2
 
 Muito confuso.
 Mas ele mostra os posicionamentos na tela usando coordenadas
 GeometryReader { proxy in
      Text("Center")
          .background(.blue)
          .onTapGesture {
              print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
              print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
              print("Local center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
          }
  }
 
 -------
 Day 93 - aula 1
 
 Ele mostrou o GeometryReader
 HStack e VStack não sao consideradas como containers

 Ex:
 HStack {
     Text("IMPORTANT")
         .frame(width: 200)
         .background(.blue)

     Image(.example)
         .resizable()
         .scaledToFit()
         .containerRelativeFrame(.horizontal) { size, axis in
             size * 0.8
         }
 }
 
 aqui, o Texto ficará pra fora da tela, usando o GeometryReader() a gente resolve isso
 
 GeometryReader { proxy in
     Image(.example)
         .resizable()
         .scaledToFit()
         .frame(width: proxy.size.width * 0.8)
 }
 
 porem a imagem vai pro topo da tela, então temos que adicionar:
 
 GeometryReader { proxy in
     Image(.example)
         .resizable()
         .scaledToFit()
         .frame(width: proxy.size.width * 0.8)
         .frame(width: proxy.size.width, height: proxy.size.height) <--- essa linha
 }

 ---------
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

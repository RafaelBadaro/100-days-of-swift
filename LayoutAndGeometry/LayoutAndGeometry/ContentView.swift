//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Rafael Badaró on 28/08/25.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .global).minY
                        let fullViewHeight = fullView.size.height
                        let normalized = minY / fullViewHeight
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            //.background(colors[index % 7]) Comentando para o Challenge #3
                            /*
                             Challenge #3
                             Aqui foi bem simples kkkk eu só troquei pra usar o  Color(hue:saturation:brightness:)
                             e enviei os valores "variantes" para o hue
                             e na propria descricao do tutorial ele fala pra "use min() with the hue so that hue values don’t go beyond 1.0."
                             então coloquei min(normalized, 1)
                             */
                            .background(Color(hue: min(normalized, 1), saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(minY - fullViewHeight / 2) / 5,
                                              axis: (x: 0, y: 1, z: 0))
                            /*
                             Challenge #1
                             GPT: o minY dá a coordenada Y mínima (topo) da view em relação ao sistema de coordenadas global da tela.
                             Mede a distância do topo da tela até o topo da view que está dentro do GeometryReader.
                             Esse valor muda quando você rola (scroll), já que a posição global da view em relação à tela muda.
                            
                            No meu caso, é o topo da tela até o topo da Text
                             */
                            .opacity(minY <= 50 ? 0 : 1)
                        
                            /*
                             Challenge #2
                             Esse daqui foi mais dificil, usei o GPT pra me ajudar a pensar em um jeito de normalizar os dados pra ficar entre 0 até 1
                                Porque? Porque o Scale que eu queria é basicamente 1 (tamanho normal) até no MÁXIMO 0.5 (metade do tamanho)
                                Só que eu não tinha pensado em uma maneira de fazer com que:
                                O quanto mais perto do bottom, maior o Scale
                                E quanto mais perto do top, menor o Scale (até num maximo de 0.5)
                                Então o GPT sugeriu de pegar a altura da view toda: (fullView.size.height)
                                Dividido pelo minY (proxy.frame(in: .global).minY)
                                Isso representa a posição da view relativa à altura da tela em uma escala entre 0 a 1
                             Pra ver melhor, só colocar esse código aqui, vai dar pra ver que o "normalizado" retorna 0,0 alguma coisa quanto mais perto do topo
                                 e 1.0 alguma coisa quanto mais perto do bottom
                             
                             Text("minY: \(Int(proxy.frame(in: .global).minY)) normalizado \(proxy.frame(in: .global).minY / fullView.size.height)")
                                                       .font(.caption)
                                                       .foregroundColor(.white)
                                                       .padding(4)
                                                       .background(.black.opacity(0.5))
                                                       .cornerRadius(5)
                             */
                            .scaleEffect(max(normalized, 0.5))
                    }
                    .frame(height: 40)
                }
            }
        }
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

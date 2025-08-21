//
//  ContentView.swift
//  Flashzilla
//
//  Created by Rafael Badaró on 19/08/25.
//

import SwiftUI


extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @State private var cards = Array<Card>(repeating: .example, count: 10)
    
    var body: some View {
        ZStack {
            
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index])
                            .stacked(at: index, in: cards.count)
                    }
                }
            }
            
        }
        
        
    }
}

#Preview {
    ContentView()
}

/*
 Day 87 - Aula 3
 
 struct ContentView: View {
     @Environment(\.accessibilityReduceTransparency) var accessibilityReduceTransparency
     
     var body: some View {
         Text("Hello World!")
             .padding()
             .background(accessibilityReduceTransparency ? .black : .black.opacity(0.5))
             .foregroundStyle(.white)
             .clipShape(.capsule)
     }
 }
 
 
 func withOptionAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
     if UIAccessibility.isReduceMotionEnabled {
         return try body()
     }
     
     return try withAnimation(animation, body)
 }

 struct ContentView: View {
     @State private var scale = 1.0
     
     var body: some View {
         Button("Hello World!") {
             withOptionAnimation {
                 scale *= 1.5
             }
         }
         .scaleEffect(scale)
     }
 }
 
 
 struct ContentView: View {
     @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
     @State private var scale = 1.0
     
     var body: some View {
         Button("Hello World!") {
             if accessibilityReduceMotion {
                 scale *= 1.5
             } else {
                  withAnimation {
                     scale *= 1.5
                 }
             }
         }
         .scaleEffect(scale)
     }
 }
 
 struct ContentView: View {
     @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
     
     var body: some View {
         HStack {
             if accessibilityDifferentiateWithoutColor {
                 Image(systemName: "checkmark.circle")
             }
             
             Text("Success")
         }
         .padding()
         .background(accessibilityDifferentiateWithoutColor ? .black : .green)
         .foregroundStyle(.white)
         .clipShape(.capsule)
     }
 }
 
 --------------
 Day 87 - Aula 2
 
 struct ContentView: View {
     @Environment(\.scenePhase) var scenePhase
     
     var body: some View {
         Text("Hello World")
             .onChange(of: scenePhase) { oldPhase, newPhase in
                 if newPhase == .active {
                     print("Active")
                 } else if newPhase == .inactive {
                     print("Inactive")
                 } else {
                     print("Background")
                 }
             }

     }
 }
 
 
 --------------
 Day 87 - Aula 1

 struct ContentView: View {
     let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
     @State private var counter = 0
     
     var body: some View {
         Text("Hello World")
             .onReceive(timer) { time in
                 if counter == 5 {
                     timer.upstream.connect().cancel()
                 } else {
                     print("The time is now \(time)")
                 }
                 
                 counter += 1
             }
     }
 }
 
 
 --------------
 Day 86 - Aula 3
 
 struct ContentView: View {
     var body: some View {
         VStack {
             Text("Hello")
             
             Spacer()
                 .frame(height: 100)
             
             Text("World")
         }
         .contentShape(.rect)
         .onTapGesture {
             print("VStack tapped!")
         }
     }
 }

 
 
 struct ContentView: View {
     var body: some View {
         ZStack {
             Rectangle()
                 .fill(.blue)
                 .frame(width: 300, height: 300)
                 .onTapGesture {
                     print("Rectangle Tapped")
                 }
             
             Circle()
                 .fill(.red)
                 .frame(width: 300, height: 300)
                 .contentShape(.rect)
                 .onTapGesture {
                     print("Circle Tapped")
                 }
                 //.allowsHitTesting(false)
         }
     }
 }
 
 
 
 --------------
 Day 86 - Aula 2
 
 struct ContentView: View {
     @State private var offset = CGSize.zero
     @State private var isDragging = false
     
     var body: some View {
         let dragGesture = DragGesture()
             .onChanged { value in
                 offset = value.translation
             }
             .onEnded { _ in
                 withAnimation {
                     offset = .zero
                     isDragging = false
                 }
             }

         let pressGesture = LongPressGesture()
             .onEnded { value in
                 withAnimation {
                     isDragging = true
                 }
             }
         
         let combied = pressGesture.sequenced(before: dragGesture)
         
         Circle()
             .fill(.red)
             .frame(width: 64, height: 64)
             .scaleEffect(isDragging ? 1.5 : 1)
             .offset(offset)
             .gesture(combied)
     }
 }
 
 struct ContentView: View {
     
     var body: some View {
         VStack {
             Text("Hello, world!")
                 .onTapGesture {
                     print("Text tapped")
                 }
         }.simultaneousGesture(
             TapGesture()
                 .onEnded {
                     print("Vstack tapped")
                 }
         )

     }
 }
 
 struct ContentView: View {
     @State private var currentAmount = Angle.zero
     @State private var finalAmount = Angle.zero
     
     var body: some View {
         Text("Hello, world!")
             .rotationEffect(currentAmount + finalAmount)
             .gesture(
                 RotateGesture()
                     .onChanged { value in
                         currentAmount = value.rotation
                     }
                     .onEnded { value in
                         finalAmount += currentAmount
                         currentAmount = .zero
                     }
             )
     }
 }

 
 struct ContentView: View {
     @State private var currentAmount = 0.0
     @State private var finalAmount = 1.0
     
     var body: some View {
         Text("Hello, world!")
             .scaleEffect(finalAmount + currentAmount)
             .gesture(
                 MagnifyGesture()
                     .onChanged { value in
                         currentAmount = value.magnification - 1
                     }
                     .onEnded { value in
                         finalAmount += currentAmount
                         currentAmount = 0
                     }
             )
     }
 }
 
 */

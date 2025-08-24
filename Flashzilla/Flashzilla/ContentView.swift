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
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var cards = [Card]() //Array<Card>(repeating: .example, count: 10)
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive: Bool = true
    
    @State private var showingEditingScreen = false
        
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditingScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                        
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if !cards.isEmpty {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditingScreen, onDismiss: resetCards, content: EditCardsView.init)
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
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

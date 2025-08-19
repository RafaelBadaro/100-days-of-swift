//
//  ContentView.swift
//  Flashzilla
//
//  Created by Rafael Badaró on 19/08/25.
//

import SwiftUI

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

#Preview {
    ContentView()
}

/*
 Day 86 - Aula 3
 
 
 
 
 
 -------
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

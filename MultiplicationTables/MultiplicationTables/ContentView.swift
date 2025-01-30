//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Rafael Badaró on 29/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAskingForSettings = true
    @State private var upToNumber = 1
    @State private var numberOfQuestions = 5
    let numberOfQuestionsAvailable = [5,10,20]
    
    @State private var score = 0
    
    @State private var currentAnswer: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                if isAskingForSettings {
                    Section("Up to which number you want to practice?") {
                        Stepper("Up to \(upToNumber)",
                                value: $upToNumber, in: 1...10)
                    }
                    .padding(.bottom)
                    
                    Section("How many questions do you want to be asked?") {
                        Picker("Number of questions", selection: $numberOfQuestions) {
                            ForEach(numberOfQuestionsAvailable,
                                    id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.bottom)
                    
                    Button {
                        isAskingForSettings.toggle()
                    } label: {
                        Text("Start!")
                            .font(.title)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    
                } else {
                    //TODO: finalizar essa logica
                    VStack{
                        Text("Question #1")
                            .font(.title)
                        Text("What is \(Int.random(in: 1...upToNumber))?")
                            .font(.headline)
                        
                        TextField("Answer",
                                  value: $currentAnswer,
                                  format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    }
                    
                }
                
            }
            .navigationTitle("Multiplication Tables :)")
            .padding()
            .toolbar {
                if !isAskingForSettings {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isAskingForSettings.toggle()
                        } label: {
                            Text("Restart")
                        }
                    }
                }

            }
        }

        
    }
}

#Preview {
    ContentView()
}

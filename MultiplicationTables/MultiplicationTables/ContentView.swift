//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Rafael Badaró on 29/01/25.
//

import SwiftUI

struct Question {
    let randomUpToNumber: Int
    let fixed1to10Number: Int
    let correctAnswer: Int
    let questionText: String
    
    init(randomUpToNumber: Int, fixed1to10Number: Int) {
        self.randomUpToNumber = randomUpToNumber
        self.fixed1to10Number = fixed1to10Number
        self.correctAnswer = randomUpToNumber * fixed1to10Number
        self.questionText = "Whats \(randomUpToNumber) x \(fixed1to10Number)?"
    }
}

struct ContentView: View {
    
    @State private var isAskingForSettings = true
    @State private var upToNumber = 1
    @State private var numberOfQuestions = 5
    let numberOfQuestionsAvailable = [5,10,20]
    
    @State private var score = 0
    
    @State private var currentAnswer: Int? = nil
    
    @State private var questions: [Question] = []
    
    @State private var currentQuestionNumber = 0
    
    @State private var isGameOver = false

    var body: some View {
        NavigationStack {
            VStack {
                if isAskingForSettings {
                    Section("Up to which multiplication tables you want practice?") {
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
                        startGame()
                    } label: {
                        Text("Start!")
                            .font(.title)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    
                } else {
                    
                    VStack {
                        
                        if isGameOver {
                            Text("Game over! Your score: \(score)!")
                                .font(.title)
                            
                            Button {
                                restartGame()
                            } label: {
                                Text("Play again?")
                                    .font(.title)
                            }
                            .padding()
                            .buttonStyle(.borderedProminent)
                            
                        } else {
                            Text("Question #\(currentQuestionNumber + 1)")
                                .font(.title)
                            
                            Text("\(questions[currentQuestionNumber].questionText)")
                                .font(.headline)
                            
                            TextField("Answer",
                                      value: $currentAnswer,
                                      format: .number)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            
                            Button {
                                goToNextQuestion()
                            } label: {
                                Text("Next question")
                                    .font(.title)
                            }
                            .disabled(currentAnswer == nil)
                            .padding()
                            .buttonStyle(.borderedProminent)
                            
                        }
                        
                    }
                    
                    
                }
                
            }
            .navigationTitle("Multiplication Tables :)")
            .padding()
            .toolbar {
                if !isAskingForSettings && !isGameOver {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            restartGame()
                        } label: {
                            Text("Restart")
                        }
                    }
                }
                
            }
        }
    }
    
    func startGame(){
        generateQuestions()
        isAskingForSettings = false
    }
    
    // TODO: ver com gpt se existe uma maneira de tipo "resetar" as variaveis de uma view pro estado inicial, sem ter que setar na mão uma por uma
    func restartGame(){
       
        isAskingForSettings = true
        upToNumber = 1
        numberOfQuestions = 5
        
        score = 0
        currentAnswer = nil

        questions.removeAll()
        currentQuestionNumber = 0

        isGameOver = false
    }
    
    func generateQuestions(){
        for _ in 0..<numberOfQuestions{
            let randomUpToNumber = Int.random(in: 1...upToNumber)
            let fixed1to10Number = Int.random(in: 1...10)
            questions.append(
                Question(randomUpToNumber: randomUpToNumber,
                         fixed1to10Number: fixed1to10Number)
            )
        }
    }
    
    
    func goToNextQuestion(){
        
        checkScore()
        
        currentAnswer = nil
        
        if currentQuestionNumber < numberOfQuestions - 1 {
            currentQuestionNumber += 1
            return
        }
        
        isGameOver = true
    }
    
    func checkScore() {
        if currentAnswer == questions[currentQuestionNumber].correctAnswer {
            score += 1
        }
    }
    
}

#Preview {
    ContentView()
}

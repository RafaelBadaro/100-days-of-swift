
//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rafael Badaró on 27/11/24.
//

import SwiftUI

enum GameMode {
    case standard
    case deathPick
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var showEndGame = false
    @State private var endGameTitle = ""
    @State private var highScoreDeathPick = 0
    
    let MAX_SCORE = 8
    
    @State private var gameMode: GameMode = .standard
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack {
                    Text("Select Game Mode")
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Picker("Game Mode", selection: $gameMode) {
                        Text("Standard").tag(GameMode.standard)
                        Text("Death pick").tag(GameMode.deathPick)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: gameMode) {
                        reset()
                    }
                }
                .padding()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                if gameMode == .deathPick {
                    Text("High score: \(highScoreDeathPick)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                }
                
                Spacer()
                
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
        .alert(endGameTitle, isPresented: $showEndGame) {
            Button("Restart Game", action: reset)
        } message: {
            if gameMode == .deathPick {
                Text("Your score: \(score)")
            } else {
                Text("") // No message for .standard
            }
        }
    }
    
    func reset() {
        score = 0
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if gameMode == .standard {
            standardGame(number)
        } else if gameMode == .deathPick {
            deathPickGame(number)
        }
    }
    
    private func standardGame(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! Thats the flag of \(countries[number])"
        }
        
        if score == MAX_SCORE {
            endGameTitle = "Max score reached!"
            showEndGame = true
        } else {
            showingScore = true
        }
    }
    
    private func deathPickGame(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            if score > highScoreDeathPick {
                highScoreDeathPick = score
            }
            showingScore = true
        } else {
            endGameTitle = "Wrong! Game over"
            showEndGame = true
        }
    }
}

#Preview {
    ContentView()
}

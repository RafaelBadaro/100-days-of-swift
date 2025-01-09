//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Rafael Badaró on 08/01/25.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["🪨", "🧻", "✂️"]
    
    @State private var appsChoice = "🪨"
    @State private var shouldWin = Bool.random()
    @State private var timesPlayed: Int = 0
    @State private var score: Int = 0
    @State private var showAlertEndGame = false
    
    var body: some View {
        VStack {
            HStack{
                Text("Times played: \(timesPlayed)")
                    .font(.headline)
                Text("Current score: \(score)")
                    .font(.headline)
            }
            .padding()
            
            HStack {
                Text("How do you ")
                + Text(shouldWin ? "win" : "lose")
                    .fontWeight(.bold)
                    .foregroundColor(shouldWin ? .green : .red)
                + Text(" against \(appsChoice)")
            }
            .padding()
            .font(.system(size: 25))
            
            HStack {
                Button("🪨") { userChoseRock() }
                    .buttonStyle(.borderedProminent)
                Button("🧻") { userChosePaper() }
                    .buttonStyle(.borderedProminent)
                Button("✂️") { userChoseScissors() }
                    .buttonStyle(.borderedProminent)
            }
            .padding()
            .font(.system(size: 65))
        }
        .padding()
        .alert("Result",
               isPresented: $showAlertEndGame) {
            Button("OK", role: .cancel) {
                restartGame()
            }
        } message: {
            Text("Game ended! Restarting...")
        }
    }
    
    func userChoseRock() {
        if shouldWin {
            if appsChoice == "✂️" {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if appsChoice == "🧻" {
                score += 1
            } else {
                score -= 1
            }
        }
        
        timesPlayed += 1
        nextQuestion()
    }
    
    func userChosePaper() {
        if shouldWin {
            if appsChoice == "🪨" {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if appsChoice == "✂️" {
                score += 1
            } else {
                score -= 1
            }
        }
        
        timesPlayed += 1
        nextQuestion()
    }
    
    func userChoseScissors() {
        if shouldWin {
            if appsChoice == "🧻" {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if appsChoice == "🪨" {
                score += 1
            } else {
                score -= 1
            }
        }
        
        timesPlayed += 1
        nextQuestion()
    }
    
    func nextQuestion() {
        if timesPlayed < 10 {
            scramble()
        }
        
        if timesPlayed == 10 {
            showAlertEndGame = true
        }
    }
    
    func scramble(){
        changeCurrentChoice()
        changeShouldWin()
    }
    
    func restartGame() {
        scramble()
        timesPlayed = 0
        score = 0
    }
    
    func changeCurrentChoice() {
        let randomNumber = Int.random(in: possibleMoves.indices)
        appsChoice = possibleMoves[randomNumber]
    }
    
    func changeShouldWin() {
        shouldWin.toggle()
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Rafael Badaró on 08/01/25.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["🪨", "🧻", "✂️"]
    
    /**
     So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.
     
     A ideia é de que, se for pra ganhar ("win") , você deve escolher o que naturalmente escolheria para vencer o elemento escolhido pelo app.
     
     E se for pra perder("lose") , tem que escolher o que perderia para  o elemento escolhido pelo app.
     
     Casos possíveis ilustrados:
     
     
     (Chat gpt)
     Se o objetivo é ganhar contra a escolha do app (appsChoice), você deve escolher algo que vença a escolha do app no jogo de pedra, papel e tesoura:
     
     "🪨" (Rock): vence "✂️" (Scissors).
     "🧻" (Paper): vence "🪨" (Rock).
     "✂️" (Scissors): vence "🧻" (Paper).
     
     Se o objetivo é perder, você deve escolher algo que perca para a escolha do app:
     
     "🪨" (Rock): perde para "🧻" (Paper).
     "🧻" (Paper): perde para "✂️" (Scissors).
     "✂️" (Scissors): perde para "🪨" (Rock).
     
     */
    
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

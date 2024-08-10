//
//  ContentView.swift
//  dice-game
//
//  Created by Rafael Badaró on 10/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var game = Game()
    
    var body: some View {
        ZStack{
            Color.cyan.opacity(0.5)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack{
                
                Text(game.message)
                    .font(.title)
                    .padding()
                
                HStack{
                    VStack {
                        Text("Player 1")
                            .font(.headline)
                        
                        HStack{
                            Image(systemName: "dice.fill")
                                .font(.largeTitle)
                                .symbolEffect(.bounce.up.byLayer, value: game.player1DiceResult)
                                .foregroundStyle(.blue)
                                .padding()
                            
                            Text(String(game.player1DiceResult))
                                .foregroundStyle(.blue)
                                .font(.title)
                        }
                        .padding()
                        
                        Text("Score: \(game.player1Score)")
                    }
                    .padding()
                    
                    VStack{
                        Text("Player 2")
                            .font(.headline)
                        
                        HStack{
                            Image(systemName: "dice.fill")
                                .font(.largeTitle)
                                .symbolEffect(.bounce.up.byLayer, value: game.player2DiceResult)
                                .foregroundStyle(.green)
                                .padding()
                            
                            Text(String(game.player2DiceResult))
                                .foregroundStyle(.green)
                                .font(.title)
                        }
                        .padding()
                        
                        
                        Text("Score: \(game.player2Score)")
                    }
                    .padding()
                }
                .padding()
                
                VStack {
                    Button {
                        game.playGame()
                    } label: {
                        Text("PLAY GAME")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    Button {
                        game.restartGame()
                    } label: {
                        Text("RESTART GAME")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                }
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}

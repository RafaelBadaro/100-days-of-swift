//
//  GameCreationView.swift
//  day95-challenge-DiceRoll
//
//  Created by Rafael Badaró on 31/08/25.
//

import SwiftUI

struct GameCreationView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var game: Game
        
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(DiceSides.allCases, id: \.self) { side in
                    HStack {
                        Text("Dice with \(side.rawValue) sides")
                        
                        Spacer()
                        //TODO: fazer com que esses botões parem de "se mexer" na medida que a quantity muda
                        HStack(spacing: 20) {
                            Button {
                                removeDice(ofSide: side)
                            } label: {
                                Image(systemName: "minus")
                                    .foregroundColor(.blue)
                            }
                            
                            Button {
                                addDice(ofSide: side)
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding([.leading, .trailing])
                                                
                        Text("\(getDiceQuantity(ofSide: side))")
                    }
                    .padding()
                    
                }
                
                Button("Create game", action: createGame)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Create game")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        resetDices()
                    }
                }
                
            }
        }
    }
    
    func getDiceQuantity(ofSide side: DiceSides) -> Int {
        return self.game.sidesAndQuantity[side] ?? 0
    }
    
    func addDice(ofSide side: DiceSides) {
        if let quantity = self.game.sidesAndQuantity[side] {
            self.game.sidesAndQuantity[side] = quantity + 1
        } else {
            self.game.sidesAndQuantity[side] = 1
        }
    }
    
    func removeDice(ofSide side: DiceSides) {
        if let quantity = self.game.sidesAndQuantity[side], quantity > 0 {
            self.game.sidesAndQuantity[side] = quantity - 1
        }
    }
    
    func resetDices() {
        self.game.sidesAndQuantity = [:]
    }
    
    func createGame() {
        dismiss()
    }
}

#Preview {
    GameCreationView(game: .constant(Game(sidesAndQuantity: [:], total: 0)))
}

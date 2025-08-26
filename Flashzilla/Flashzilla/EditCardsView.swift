//
//  EditCards.swift
//  Flashzilla
//
//  Created by Rafael Badaró on 24/08/25.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                addCardSection
                cardsListSection
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: loadData)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "cards")
        }
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        clearFields()
        saveData()
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    func clearFields() {
        newPrompt = ""
        newAnswer = ""
    }
    
}

private extension EditCardsView {
    private var addCardSection: some View {
        Section("Adding a new card") {
            TextField("Prompt", text: $newPrompt)
            TextField("Answer", text: $newAnswer)
            
            Button("Add Card", action: addCard)
        }
    }

    private var cardsListSection: some View {
        Section {
            ForEach(0..<cards.count, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text(cards[index].prompt)
                        .font(.headline)
                    Text(cards[index].answer)
                        .foregroundStyle(.secondary)
                }
            }
            .onDelete(perform: removeCards)
        }
    }
    
}

#Preview {
    EditCardsView()
}

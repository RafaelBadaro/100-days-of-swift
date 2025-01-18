//
//  ContentView.swift
//  WordScramble
//
//  Created by Rafael Badaró on 15/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make em up, you know!")
            return
        }
        
        withAnimation {
            
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

#Preview {
    ContentView()
}


//    func testStrings() {
////        let input = """
////        a
////        b
////        c
////        """
////        let letters = input.components(separatedBy: "\n")
////        let letter = letters.randomElement()
////        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        let word = "swift"
//        let checker = UITextChecker()
//
//        let range = NSRange(location: 0, length: word.utf16.count)
//        let misspelledRange = checker.rangeOfMisspelledWord(in: word,
//                                                            range: range,
//                                                            startingAt: 0,
//                                                            wrap: false,
//                                                            language: "en")
//
//        let allGood = misspelledRange.location == NSNotFound
//    }

// Quando acontece um build, o bundle é criado, e nele tem todos os arquivos do projeto
// Para acessar ele, tem que usar o Bundle.main.url
//    func testBundles() {
//        if let fileURL = Bundle.main.url(forResource: "somefile", withExtension: "txt") {
//            // we found the file in our bundle!
//
//            if let fileContents = try? String(contentsOf: fileURL) {
//                // we loaded the file into a string
//            }
//        }
//    }


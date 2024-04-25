//
//  ContentView.swift
//  WordScramble
//
//  Created by Marco Capraro on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Enter a new word: ", text: $newWord)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Word: \(rootWord)")
                        .underline()
                        .font(.largeTitle.weight(.bold))
                        .padding(.top, 25)
                }
            }
            .onAppear(perform: startGame)
            .onSubmit {
                addNewWord()
            }
            .alert(errorTitle, isPresented: $showAlert) {
                Button("Ok") {}
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        // Remove whitespace, case-sensitivity, and ensure not a blank answer
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        // Extra validation
        guard isOriginal(word: answer) else {
            wordError(title: "Repeated Word", message: "You can be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Impossible Word", message: "You can't spell that word from \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Unrecognized word", message: "You can't just make stuff up!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame() {
        // Search for url in bundle
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Try to assign url content to a single string
            if let startWords = try? String(contentsOf: startWordsUrl) {
                // Seperate string into an array of strings (aka words) and assign random root
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "condense"
                return
            }
        }
        
        // In the event the start.txt cannot load, cause crash since rest of app will not function
        fatalError("Could not load start.txt from bundle.")
    }
    
    // Check if the inputted word has already been inserted by the user
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    // Check if the inputted word exists in the root word
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        // Iterate through each letter in the inputted user word
        for letter in word {
            // If the letter exists in the root word, remove it and check the next
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
            
        }
        
        // In the event all the letters are removed then the word is possible from the root
        return true
    }
    
    // Check if the inputted word is mispelled
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return mispelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showAlert = true
    }
}

#Preview {
    ContentView()
}

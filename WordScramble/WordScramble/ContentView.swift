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
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Enter a new word: ", text: $newWord)
                    .textInputAutocapitalization(.never)
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        Text(word)
                    }
                }
            }
            .onSubmit {
                addNewWord()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(rootWord)
                        .font(.largeTitle.weight(.bold))
                }
            }
        }
    }
    
    func addNewWord() {
        // Remove whitespace, case-sensitivity, and ensure not a blank answer
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        // Extra validation
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
}

#Preview {
    ContentView()
}

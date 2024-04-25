//
//  ContentView.swift
//  WordScramble
//
//  Created by Marco Capraro on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    let people = ["Gianluca", "Alessandro", "Giuliana", "Marco"]
    
    var body: some View {
        
        List {
            Text("Static Row")
            
            Section("Dynamic Row") {
                ForEach(people, id: \.self) {
                    Text($0)
                }
            }
            
            Text("Static Row")
        }
        .listStyle(.grouped)
    }
    
    func testBundles() {
        if let fileUrl = Bundle.main.url(forResource: "someFile", withExtension: "txt") {
            // We found the file in our bundle
            if let fileString = try? String(contentsOf: fileUrl) {
                // We loaded the url contents into a single string
            }
        }
    }
    
    func testStrings() {
        let test = "a b c"
        
        let letters = test.components(separatedBy: " ")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func spellChecker() {
        // Declare word and a checker to check for mispelling
        let word = "swift"
        let checker = UITextChecker()
        
        // Determine the range to check and the mispelled range
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        // In the event NSNotFound is at the first index, there is no mispelling
        let allGood =  mispelledRange.location == NSNotFound
    }
}

#Preview {
    ContentView()
}

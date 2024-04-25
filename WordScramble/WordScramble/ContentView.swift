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
}

#Preview {
    ContentView()
}

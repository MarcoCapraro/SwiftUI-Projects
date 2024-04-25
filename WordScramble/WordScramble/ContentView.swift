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
}

#Preview {
    ContentView()
}

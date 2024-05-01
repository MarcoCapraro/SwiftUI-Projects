//
//  ContentView.swift
//  TableTime
//
//  Created by Marco Capraro on 5/1/24.
//

import SwiftUI

struct TableTitle: View {
    var body: some View {
        Text("Table Time")
            .font(.custom("SuperBubble", size: 32, relativeTo: .title))
            .foregroundStyle(.green)
            .padding()
            .background(.black)
            .clipShape(.capsule)
            .padding(.top, 20)
    }
}

struct ContentView: View {
    @State private var animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"].shuffled()
    @State private var randomAnimal = "whale"
    
    @State private var scaleAmount = 1.0
    @State private var fadeAmount = 1.0
    @State private var changeAnimal = false
    
    @State private var randomSpawn: CGPoint = CGPoint(x: .random(in: 0..<9*(UIScreen.main.bounds.width/10)), y: .random(in: 0..<9*(UIScreen.main.bounds.height/10)))
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cyan
                    .ignoresSafeArea()
                
                Image(randomAnimal)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .position(randomSpawn)
        
                VStack {
                    Text("Test")
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        TableTitle()
                    }
                }
            }
        }
    }
    
    func newSpawn() {
        fadeAmount = 1.0
        animals = animals.shuffled()
        randomAnimal = animals[0]
        randomSpawn = CGPoint(x: .random(in: 0..<9*(UIScreen.main.bounds.width/10)), y: .random(in: 0..<9*(UIScreen.main.bounds.height/10)))
    }
    
    // Identify font names
    func checkFontNames() {
        for family in UIFont.familyNames {
            let sName: String = family as String
                print("family: \(sName)")
                        
                for name in UIFont.fontNames(forFamilyName: sName) {
                    print("name: \(name as String)")
                }
        }
    }
}

#Preview {
    ContentView()
}

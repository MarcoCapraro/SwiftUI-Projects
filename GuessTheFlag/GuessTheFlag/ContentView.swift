//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Marco Capraro on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.blue, .black], center: .center, startRadius: 100, endRadius: 350)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                    Text("\(countries[correctAnswer])")
                        .font(.largeTitle.weight(.semibold))
                }
                .foregroundStyle(.white)
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(color: .black, radius: 10)
                    }
                }
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askNextQuestion)
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if(number == correctAnswer) {
            // alert success
            scoreTitle = "Correct"
        } else {
            // alert failure
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askNextQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}

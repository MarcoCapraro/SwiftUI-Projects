//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Marco Capraro on 4/12/24.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .resizable()
            .aspectRatio(1.5, contentMode: .fit)
            .frame(width: 200, height: 100)
            .clipShape(.circle)
            .shadow(color: .black, radius: 10)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingRestart = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionCounter = 0
    
    @State private var selectedFlag = -1
    @State private var isCorrectFlag = false
    @State private var isWrongFlag = false
    @State private var isOtherFlag = false
    
    let labels = [
        "Estonia": "Flag 3 horizontal stripes. Top to bottom, blue, black, white",
        "France": "Flag 3 vertical stripes. Left to right, blue, white, red",
        "Germany": "Flag 3 horizontal stripes. Top to bottom, black, red, gold",
        "Ireland": "Flag 3 vertical stripes. Left to right, green, white, orange",
        "Italy": "Flag 3 vertical stripes. Left to right, green, white, red",
        "Monaco": "Flag 2 horizontal stripes. Top to bottom, red, white",
        "Nigeria": "Flag 3 vertical stripes. Left to right, green, white, green",
        "Poland": "Flag 2 horizontal stripes. Top to bottom, white, red",
        "Spain": "Flag 3 horizontal stripes. Top to bottom, red, gold, red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "Ukraine": "Flag 2 horizontal stripes. Top to bottom, blue, yellow",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.blue, .black], center: .center, startRadius: 150, endRadius: 450)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text("\(countries[correctAnswer])")
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundStyle(.black)
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .accessibilityLabel(labels[countries[number], default: "Uknown Flag"])
                        .rotation3DEffect(
                            .degrees(isCorrectFlag && selectedFlag == number ? 360 : 0),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .opacity(isOtherFlag && selectedFlag != number ? 0.25 : 1.0)
                        .rotation3DEffect(
                            .degrees(isWrongFlag && selectedFlag != number ? 270 : 0),
                            axis: (x: 1.0, y: 0.0, z: 0.0)
                        )
                        .scaleEffect(isWrongFlag && selectedFlag != number ? 0.5 : 1.0)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                Text("Question: \(questionCounter)/8")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askNextQuestion)
        } message: {
            Text("Score: \(score)")
        }
        .alert("You scored \(score)/8", isPresented: $showingRestart) {
            Button("Restart", role: .cancel, action: resetGame)
        } message: {
            if(score > 5) {
                Text("Great job!")
            } else {
                Text("Better luck next time!")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedFlag = number
        if(number == correctAnswer) {
            // alert success
            isCorrectFlag = true
            isOtherFlag = true
            scoreTitle = "Correct! That's \(countries[number])"
            score += 1
        } else {
            // alert failure
            isWrongFlag = true
            scoreTitle = "Wrong! That's \(countries[number])"
        }
        
        questionCounter += 1
        if(questionCounter == 8) {
            showingRestart = true
        } else {
            showingScore = true
        }
    }
    
    func askNextQuestion() {
        isCorrectFlag = false
        isOtherFlag = false
        isWrongFlag = false
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        questionCounter = 0
        scoreTitle = ""
        score = 0
        
        askNextQuestion()
    }
}

#Preview {
    ContentView()
}

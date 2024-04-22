//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Marco Capraro on 4/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var opponentHands = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var randomHand = Int.random(in: 0...2)
    @State private var gameCondition = Bool.random()
    @State private var score = 0
    
    let handImages = ["mountain.2.circle", "newspaper.circle", "scissors.circle"]
    let handOptions = ["Rock", "Paper", "Scissors"]
        
    func optionTapped(_ num: Int) {
        let opponentHand = opponentHands[randomHand]
        var answeredCorrectly = false
        
        // Determine winning option
        if(gameCondition) {
            if(opponentHand == "Rock") {
                answeredCorrectly = handOptions[num] == "Paper" ? true : false
            } else if(opponentHand == "Paper") {
                answeredCorrectly = handOptions[num] == "Scissors" ? true : false
            } else {
                answeredCorrectly = handOptions[num] == "Rock" ? true : false
            }
            
        // Determine losing option
        } else {
            if(opponentHand == "Rock") {
                answeredCorrectly = handOptions[num] == "Scissors" ? true : false
            } else if(opponentHand == "Paper") {
                answeredCorrectly = handOptions[num] == "Rock" ? true : false
            } else {
                answeredCorrectly = handOptions[num] == "Paper" ? true : false
            }
        }
                
        if(answeredCorrectly) {
            score += 1
        } else {
            // do nothing
        }
        
        nextQuestion()
    }
    
    func nextQuestion() {
        opponentHands = opponentHands.shuffled()
        randomHand = Int.random(in: 0...2)
        gameCondition.toggle()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
        
                    Text("Opponent Chooses: \(opponentHands[randomHand])")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                    Text("What Hand **\(gameCondition ? "Wins" : "Loses")** this Turn?")
                        .font(.callout.weight(.light))
                        .foregroundStyle(.white)
                    
                    
                    
                    HStack {
                        ForEach(0..<3) { number in
                            ZStack {
                                RadialGradient(colors: [.red, .black], center: .center, startRadius: 10, endRadius: 55)
                            
                                Button {
                                    // choice tapped
                                    optionTapped(number)
                                } label: {
                                    Image(systemName: handImages[number])
                                        .resizable()
                                        .frame(maxWidth: 100, maxHeight: 100)
                                }
                                .foregroundStyle(.white)
                            }
                            .frame(maxWidth: 150, maxHeight: 150)
                            
                            
                        }
                    }
                    .padding()
                    .padding(.bottom, 100)
                                        
                    Text("Score - \(score) ")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    Spacer()
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Rock Paper Scissors")
                            .underline(pattern: .dot)
                            .font(.title.weight(.heavy))
                            .foregroundStyle(.white)
                            .accessibilityAddTraits(.isHeader)
                    }
                }
            }
        }
            
        
    }
}

#Preview {
    ContentView()
}

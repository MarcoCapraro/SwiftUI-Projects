//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Marco Capraro on 4/22/24.
//

import SwiftUI

struct RPSImage: View {
    var sysString: String
    
    var body: some View {
        Image(systemName: sysString)
            .resizable()
            .frame(maxWidth: 100, maxHeight: 100)
    }
}

struct Title2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2.weight(.semibold))
            .foregroundStyle(.white)
    }
}

extension View {
    func title2Style() -> some View {
        modifier(Title2())
    }
}

struct ContentView: View {
    @State private var opponentHands = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var randomHand = Int.random(in: 0...2)
    @State private var gameCondition = Bool.random()
    @State private var showAlert = false
    @State private var turn = 0
    @State private var score = 0
    
    let handImages = ["mountain.2.circle", "newspaper.circle", "scissors.circle"]
    let handOptions = ["Rock", "Paper", "Scissors"]
        
    func optionTapped(_ num: Int) {
        let opponentHand = opponentHands[randomHand]
        let userChoice = handOptions[num]
        let addPoint = isCorrect(with: userChoice, against: opponentHand)
                
        if(addPoint) {
            score = min(score + 1, 10)
        } else {
            // do nothing
            score = max(score - 1, 0)
        }
        
        turn = min(turn + 1, 10)
        nextQuestion()
    }
    
    func isCorrect(with choice: String, against hand: String) -> Bool {
        var result: Bool = false
        // Determine winning option
        if(gameCondition) {
            if(hand == "Rock") {
                result = choice == "Paper" ? true : false
            } else if(hand == "Paper") {
                result = choice == "Scissors" ? true : false
            } else {
                result = choice == "Rock" ? true : false
            }
            
        // Determine losing option
        } else {
            if(hand == "Rock") {
                result = choice == "Scissors" ? true : false
            } else if(hand == "Paper") {
                result = choice == "Rock" ? true : false
            } else {
                result = choice == "Paper" ? true : false
            }
        }
        
        return result
    }
    
    func nextQuestion() {
        opponentHands = opponentHands.shuffled()
        randomHand = Int.random(in: 0...2)
        gameCondition = Bool.random()
        
        if(turn == 10) {
            // Finish game by showing alert with score and reset
            showAlert = true
        }
    }
    
    func restartGame() {
        turn = 0
        score = 0
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.black, .red], startPoint: .center, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    Text("Opponent Chooses: \(opponentHands[randomHand])")
                        .title2Style()
                    
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
                                    RPSImage(sysString: handImages[number])
                                }
                                .foregroundStyle(.white)
                            }
                            .frame(maxWidth: 150, maxHeight: 150)
                            .clipShape(.circle)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 5))
                        }
                    }
                    .padding()
                    .padding(.bottom, 100)
                    
                    Text("Completed Turns: \(turn)/10")
                        .title2Style()
                    
                    Text("Score: \(score)")
                        .title2Style()
                    
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
            .alert("Score = \(score)", isPresented: $showAlert) {
                Button("Restart", role: .cancel) {
                    restartGame()
                }
            } message: {
                Text("Can you do better?")
            }
        }
            
        
    }
}

#Preview {
    ContentView()
}

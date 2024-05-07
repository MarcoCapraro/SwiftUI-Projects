//
//  TableQuizView.swift
//  TableTime
//
//  Created by Marco Capraro on 5/6/24.
//

import SwiftUI

struct TableQuizView: View {
    var initialNum: Int = 2
    var numQuestions: Int = 5
    var animalToUnlock: String = "bear"
    
    @Environment(\.dismiss) var dismiss
    
    @State private var questionCounter = 0
    @State private var multiplyByValue = Int.random(in: 2...12)
    @State private var userAnswer = 0
    @State private var score = 0
    @State private var valuesHit: [Int] = []
    
    @FocusState private var isAnswerFocus: Bool
    @State private var isShowingAlert = false
    
    let numberMap = [2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine", 10: "Ten", 11: "Eleven", 12: "Twelve"]
    
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            
            VStack {
                Text("\(numberMap[initialNum]!) Times Table Quiz")
                    .settingStyle(alignmentSetting: .center, fontSize: 40)
                    .background(.ultraThinMaterial)
                    .lineLimit(2)
                            
                VStack {
                    Spacer()

                    Image(animalToUnlock)
                        .padding(40)
                                    
                    Text("\(initialNum) x \(multiplyByValue)?")
                        .settingStyle(alignmentSetting: .center, fontSize: 33)
                        .foregroundStyle(.pink)
                    
                    TextField("Type answer", value: $userAnswer, format: .number)
                        .settingStyle(alignmentSetting: .center, fontSize: 22)
                        .frame(maxWidth: 275)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .focused($isAnswerFocus)
                    
                    Text("Score = \(score)")
                        .settingStyle(alignmentSetting: .center, fontSize: 22)
                        .foregroundStyle(.black)
                    Spacer()
                    
                    HStack {
                        
                    }
                }
                .alert("You Scored \(score)!", isPresented: $isShowingAlert) {
                    Button("Back") {
                        dismiss()
                    }
                    Button("Retry") {
                        // Reset state
                        score = 0
                        resetQuestions()
                    }
                }
                .toolbar {
                    if isAnswerFocus {
                        Button("Done") {
                            calculateScore()
                            isAnswerFocus = false
                        }
                    }
                }
                
                Spacer()
                
                Text("Question \(questionCounter)/\(numQuestions)")
                    .settingStyle(alignmentSetting: .center, fontSize: 22)
                    .padding(10)
                    .background(.ultraThinMaterial)
            }
        }
    }
    
    func calculateScore() {
        let answer = initialNum * multiplyByValue
        if(userAnswer == answer) { score += answer * 10 } else { }
        
        // reset state for next question
        resetQuestions()
    }
    
    func resetQuestions() {
        userAnswer = 0
        if(questionCounter == numQuestions) {
            isShowingAlert = true
            questionCounter = 0
        } else {
            questionCounter += 1
        }
        
        let lastVal = multiplyByValue
        while(multiplyByValue == lastVal) {
            multiplyByValue = Int.random(in: 2...12)
        }
    }
}

#Preview {
    TableQuizView()
}

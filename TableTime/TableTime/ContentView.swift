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
            .font(.custom("SuperBubble", size: 22, relativeTo: .title))
            .foregroundStyle(.mint)
            .padding()
            .background(.indigo)
            .clipShape(.capsule)
            .ignoresSafeArea()
    }
}

struct SettingStyle: ViewModifier {
    var alignmentSetting: Alignment
    var fontSize: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom("SuperBubble", size: fontSize, relativeTo: .title2))
            .frame(maxWidth: .infinity, alignment: alignmentSetting)
            .padding(10)
    }
}

extension View {
    func settingStyle(alignmentSetting: Alignment, fontSize: CGFloat) -> some View {
        modifier(SettingStyle(alignmentSetting: alignmentSetting, fontSize: fontSize))
    }
}

struct Question {
    var questionText: String
    var questionAnswer: Int
}

struct ContentView: View {
    @State private var animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"]
    @State private var multiplicationTable: [Int] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    @State private var tableValue = 2
    @State private var totalQuestions = 5
    @State private var answer = ""
    @State private var animalButton = "bear"
    
    @State private var isShowingQuiz = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.cyan
                    .ignoresSafeArea()
        
                VStack {
                    VStack(spacing: 0) {
                        Stepper("Practice Table \(tableValue)", value: $tableValue, in: 2...12, step: 1)
                            .settingStyle(alignmentSetting: .leading, fontSize: 22)
                        
                        Stepper("\(totalQuestions) Questions", value: $totalQuestions, in: 5...20, step: 5)
                            .settingStyle(alignmentSetting: .leading, fontSize: 22)
                        
                    }
                    .background(.ultraThinMaterial)
                    .border(.black, width: 5)
                    
                    Spacer()
                    
                    VStack {
                        Text("Unlock New Animals!")
                            .settingStyle(alignmentSetting: .center, fontSize: 22)
                            .foregroundStyle(.black)
                        
                        HStack {
                            Button() {
                                swapAnimals(isForward: false)
                            } label: {
                                Image(systemName: "chevron.left")
                                    .frame(maxWidth: 150, maxHeight: 200)
                                    .font(.largeTitle)
                                    .background(.ultraThinMaterial)
                                    .clipShape(.rect(cornerRadius: 20))
                            }
                            
                            Image(animalButton)
                                .frame(minWidth: 215, minHeight: 215)
                                .padding(50)
                                .background(.ultraThinMaterial)
                                .clipShape(.circle)
                            
                            Button() {
                                swapAnimals(isForward: true)
                            } label: {
                                Image(systemName: "chevron.right")
                                    .frame(maxWidth: 150, maxHeight: 200)
                                    .font(.largeTitle)
                                    .background(.ultraThinMaterial)
                                    .clipShape(.rect(cornerRadius: 20))
                            }
                            
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: TableQuizView(initialNum: tableValue, numQuestions: totalQuestions, animalToUnlock: animalButton), isActive: $isShowingQuiz) {
                        Button("Begin") {
                            // Transition to new screen, transfering tableValue and totalQuestions
                            isShowingQuiz = true
                        }
                        .font(.custom("SuperBubble", size: 50, relativeTo: .title2))
                        .foregroundStyle(.mint)
                        .padding(20)
                        .background(.indigo)
                        .clipShape(.capsule)
                    }

                    
                    Spacer()
                    
                }
                .padding(40)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image("cow")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 60, maxHeight: 60)
                            TableTitle()
                            Image("goat")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 60, maxHeight: 60)
                        }
                    }
                }
            }
        }
    }
    
    func swapAnimals(isForward: Bool) {
        guard let currentIndex = animals.firstIndex(of: animalButton) else { return }
        var nextIndex = 0
        
        if isForward {
            nextIndex = min(currentIndex + 1, animals.count - 1)
        } else {
            nextIndex = max(currentIndex - 1, 0)
        }
        
        animalButton = animals[nextIndex]
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

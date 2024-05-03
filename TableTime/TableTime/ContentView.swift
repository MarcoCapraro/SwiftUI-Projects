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
            .padding(.top, 20)
    }
}

struct SettingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SuperBubble", size: 22, relativeTo: .title2))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
    }
}

extension View {
    func settingStyle() -> some View {
        modifier(SettingStyle())
    }
}

struct Question {
    var questionText: String
    var questionAnswer: Int
}

struct ContentView: View {
    //    @State private var difficultyLevels = ["Easy", "Medium", "Hard"]
    @State private var animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"]
    @State private var multiplicationTable: [Int] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    @State private var difficultyValue = "Easy"
    @State private var tableValue = 2
    @State private var totalQuestions = 5
    @State private var answer = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.cyan
                    .ignoresSafeArea()
        
                VStack {
                    Text("")
                    VStack(spacing: 0) {
                        Stepper("Practice Table \(tableValue)", value: $tableValue, in: 2...12, step: 1)
                            .settingStyle()
                        
                        Stepper("\(totalQuestions) Questions", value: $totalQuestions, in: 5...20, step: 5)
                            .settingStyle()
                        
//                        HStack {
//                            Text("Difficulty Level")
//                                .settingStyle()
//                            
//                            
//                            Picker("", selection: $difficultyValue) {
//                                ForEach(difficultyLevels, id: \.self) {
//                                    Text("\($0)")
//                                        .font(.custom("SuperBubble", size: 22, relativeTo: .title2))
//                                }
//                            }
//                            .accentColor(.black)
//                        }
                    }
                    .background(.ultraThinMaterial)
                    .border(.black, width: 5)
                    
                    Spacer()
                    
                    Image("owl")
                    
                    Spacer()
                    
                    Button("Begin") {
                        // Transition to new screen, transfering tableValue and totalQuestions
                    }
                    .font(.custom("SuperBubble", size: 50, relativeTo: .title2))
                    .foregroundStyle(.mint)
                    .padding(20)
                    .background(.indigo)
                    .clipShape(.capsule)
                    
                    Spacer()
                    
//                    Text("What is 2 x \(multiplicationTable.randomElement()!)?")
//                    TextField("input answer here", text: $answer)
//                        .frame(maxWidth: 200, alignment: .leading)
//                        .background()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image("cow")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 60, maxHeight: 60)
                                .padding(.top, 20)
                            TableTitle()
                            Image("goat")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 60, maxHeight: 60)
                                .padding(.top, 20)
                        }
                    }
                }
            }
        }
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

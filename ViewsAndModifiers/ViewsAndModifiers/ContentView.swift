//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Marco Capraro on 4/17/24.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct ContentView: View {
    @State private var isOn = false
    
    @ViewBuilder var motto1: some View {
        Text("The Golden Rule")
    }
    
    let motto2 = Text("Honesty is the best policy")
    
    var body: some View {
        VStack {
            Spacer()
            Button("Hellow World") {
                isOn.toggle()
            }
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(.background)
            .padding()
            .background(.primary)
            
            VStack {
                CapsuleText(text: "LargeTitle")
                CapsuleText(text: "Title1")
                CapsuleText(text: "Title2")
                CapsuleText(text: "Title3")
                       
                Spacer()
                motto1
                motto2
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isOn ? .green : .red)
    }
}

#Preview {
    ContentView()
}

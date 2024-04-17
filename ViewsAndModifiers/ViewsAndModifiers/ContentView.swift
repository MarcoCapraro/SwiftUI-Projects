//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Marco Capraro on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn = false
    
    var body: some View {
        VStack {
            Button("Hellow World") {
                isOn.toggle()
            }
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(.background)
            .padding()
            .background(.primary)
            
            VStack {
                Text("LargeTitle")
                    .font(.largeTitle)
                Text("Title1")
                Text("Title2")
                Text("Title3")
            }
            .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isOn ? .green : .red)
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  BetterRest
//
//  Created by Marco Capraro on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .green, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            Text("Hello, world!")
                .foregroundStyle(.indigo)
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  BetterRest
//
//  Created by Marco Capraro on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .green, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        }
    }
}

#Preview {
    ContentView()
}

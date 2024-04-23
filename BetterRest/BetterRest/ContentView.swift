//
//  ContentView.swift
//  BetterRest
//
//  Created by Marco Capraro on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                
                DatePicker("Please Enter a Future Date:", selection: $wakeUp, in: Date.now...)
                    .labelsHidden()
            }
        }
    }
}

#Preview {
    ContentView()
}

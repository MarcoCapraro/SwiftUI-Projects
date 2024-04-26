//
//  ContentView.swift
//  Animations
//
//  Created by Marco Capraro on 4/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationScale = 1.0
    @State private var animationPulse = 1.0
    
    var body: some View {
        Spacer()
        
        Stepper("Scale Amount", value: $animationScale.animation(), in: 1...2, step: 0.25)
            .frame(maxWidth: 300)
            .padding(20)
            .foregroundStyle(.black)
            .clipShape(.rect(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 5)
            )
        
        Spacer()
        
        Button("Tap Me") {
            animationScale == 2.0 ? (animationScale = 1) : (animationScale += 0.25)
        }
        .padding(25)
        .background(.black)
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .scaleEffect(animationScale)
        .blur(radius: 2.0 * (1 / animationScale))
        .animation(
            .spring(duration: 0.5, bounce: 0.75),
            value: animationScale
        )
        .overlay(
            Capsule()
                .stroke(.red, lineWidth: 3.0)
                .scaleEffect(animationPulse)
                .opacity(2 - animationPulse)
                .animation(
                    .easeOut(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: animationPulse
                )
        )
        .onAppear {
            animationPulse = 2
        }
        
        Spacer()
    }
}

#Preview {
    ContentView()
}

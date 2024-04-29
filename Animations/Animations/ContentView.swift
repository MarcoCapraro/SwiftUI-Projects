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
    @State private var animationAmount = 0.0
    
    @State private var enabled1 = false
    @State private var enabled2 = false

    
    var body: some View {
        Spacer()
        
        Stepper("Scale Amount", value: $animationScale.animation(), in: 1...2, step: 0.25)
            .frame(maxWidth: 175)
            .padding(20)
            .foregroundStyle(.black)
            .clipShape(.rect(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 5)
                    .scaleEffect(animationPulse)
                    .opacity(1.5 - animationPulse)
                    .animation(
                        .easeOut(duration: 1.0)
                            .repeatForever(autoreverses: false),
                        value: animationPulse
                    )
            )
            .onAppear {
                animationPulse = 1.5
            }
        
        Spacer()
        
        HStack {
            Spacer()
            
            Button("Tap Me") {
                enabled1.toggle()
            }
            .frame(maxWidth: 100, maxHeight: 100)
            .background(enabled1 ? .blue : .red)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: enabled1 ? 60: 0))
            .animation(.default, value: enabled1)
            
            Spacer()
            
            Button("Tap Me") {
                enabled2.toggle()
            }
            .frame(maxWidth: 200, maxHeight: 200)
            .background(enabled2 ? .blue : .red)
            .foregroundStyle(.white)
            .animation(nil, value: enabled2)
            .clipShape(.rect(cornerRadius: enabled2 ? 60: 0))
            .animation(.spring(duration: 1, bounce: 0.9), value: enabled2)
            
            Spacer()
        }
        
        Spacer()
        
        Button("Spin Me") {
            animationScale == 2.0 ? (animationScale = 1) : (animationScale += 0.25)
            withAnimation(.spring(duration: 1, bounce: 0.8)) {
                animationAmount += 360
            }
        }
        .padding(25)
        .background(.black)
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: -1.0, y: 0.0, z: 0.0))
        .scaleEffect(animationScale)
        .blur(radius: 2.0 * (1 / animationScale))
        .animation(
            .spring(duration: 0.5, bounce: 0.75),
            value: animationScale
        )
        
        Spacer()
    }
}

#Preview {
    ContentView()
}

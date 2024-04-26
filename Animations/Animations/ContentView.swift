//
//  ContentView.swift
//  Animations
//
//  Created by Marco Capraro on 4/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationScale = 1.0    
    
    var body: some View {
        Button("Tap Me") {
            animationScale == 3.0 ? (animationScale = 1) : (animationScale += 0.25)
        }
        .padding(25)
        .background(.black)
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .scaleEffect(animationScale)
        .animation(.default, value: animationScale)
    }
}

#Preview {
    ContentView()
}

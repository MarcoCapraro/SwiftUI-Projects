//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Marco Capraro on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RadialGradient(colors: [.blue, .black], center: .center, startRadius: 25, endRadius: 200)
            HStack {
                Button(role: .destructive) {
                    print("button tapped")
                } label: {
                    Label("Your Content", systemImage: "pencil.circle")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

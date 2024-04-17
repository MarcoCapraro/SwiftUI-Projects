//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Marco Capraro on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Hellow World") {
               // random
            }
            .padding()
            .background(.white)
            .padding()
            .background(.red)
            .padding()
            .background(.green)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.indigo)
    }
}

#Preview {
    ContentView()
}

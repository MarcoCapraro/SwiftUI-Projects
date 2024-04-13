//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Marco Capraro on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.blue, .black], center: .center, startRadius: 25, endRadius: 200)
            HStack {
                Button(role: .destructive) {
                    showingAlert = true
                } label: {
                    Label("Show Alert", systemImage: "exclamationmark.triangle")
                }
                .buttonStyle(.borderedProminent)
                .alert("Important Message", isPresented: $showingAlert) {
                    Button("Delete", role: .destructive) {}
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Please read this.")
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

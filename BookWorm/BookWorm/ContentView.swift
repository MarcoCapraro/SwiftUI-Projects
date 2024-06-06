//
//  ContentView.swift
//  BookWorm
//
//  Created by Marco Capraro on 6/6/24.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors:offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0:5)
    }
}

struct ContentView: View {
    @State private var rememberMe = false
    @AppStorage("note") private var notes = ""
    
    var body: some View {
        VStack {
            NavigationStack {
                TextEditor(text: $notes)
                    .navigationTitle("Notes")
                    .padding()
            }
            
            // We pass a binding of a state variable to continously update the value rememberMe via PushButton's @Binding
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On":"Off")
        }
    }
}

#Preview {
    ContentView()
}

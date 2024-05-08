//
//  ContentView.swift
//  iExpense
//
//  Created by Marco Capraro on 5/8/24.
//

import Observation
import SwiftUI

@Observable
class User {
    var firstName = "Marco"
    var lastName = "Capraro"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    let user: User
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Text("Hello, \(user.firstName)")
                Button("Dismiss") {
                    dismiss()
                }
                .font(.largeTitle)
                .foregroundStyle(.blue)
            }
        }
    }
}

struct ContentView: View {
    @State private var user = User()
    @State private var showingView = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "15.circle")
                    .font(.largeTitle)
                
                VStack {
                    Text("Your name is \(user.firstName) \(user.lastName)")
                    TextField("First Name", text: $user.firstName)
                    TextField("Last Name", text: $user.lastName)
                }
                
                Spacer()
                
                Button("Show New View") {
                    // show view
                    showingView = true
                }
                .font(.largeTitle)
                .foregroundStyle(.blue)
                .sheet(isPresented: $showingView) {
                    SecondView(user: user)
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    ContentView()
}

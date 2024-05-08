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
    @State var user: User
    
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
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Row") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                .font(.largeTitle)
                .foregroundStyle(.blue)
            }
            .toolbar {
                EditButton()
            }
            
            Spacer()
            
            Button("Show New View") {
                // show view
                showingView = true
            }
            .font(.title2)
            .foregroundStyle(.blue)
            .sheet(isPresented: $showingView) {
                SecondView(user: user)
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

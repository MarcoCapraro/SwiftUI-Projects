//
//  ContentView.swift
//  iExpense
//
//  Created by Marco Capraro on 5/8/24.
//

import Observation
import SwiftUI

//@Observable
//class User {
//    var firstName = "Marco"
//    var lastName = "Capraro"
//}

struct UserData: Codable {
    var firstName: String
    var lastName: String
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    @State private var userData = UserData(firstName: "Marco", lastName: "Capraro")
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Text("Your name is \(userData.firstName) \(userData.lastName)")
                    TextField("First Name", text: $userData.firstName)
                    TextField("Last Name", text: $userData.lastName)
                }
                .foregroundStyle(.white)
                
                Button("Save User Data") {
                    let encoder = JSONEncoder()
                    
                    if let data = try? encoder.encode(userData) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
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
    @AppStorage("tapCount") private var tapCount = 0
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
            
            HStack {
                Button("Tap Count = \(tapCount)") {
                    tapCount += 1
                }
                
                Button("Show New View") {
                    // show view
                    showingView = true
                }
                .font(.title2)
                .foregroundStyle(.blue)
                .sheet(isPresented: $showingView) {
                    SecondView()
                }
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

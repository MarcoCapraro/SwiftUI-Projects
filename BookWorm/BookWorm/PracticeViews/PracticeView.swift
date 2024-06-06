//
//  PracticeView.swift
//  BookWorm
//
//  Created by Marco Capraro on 6/6/24.
//

import SwiftData
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

struct PracticeView: View {
    @State private var rememberMe = false
    @AppStorage("note") private var notes = ""
    @Environment(\.modelContext) var modelContext
    // Property wrapper will make SwiftData load students from its model container
    @Query var students: [Student]
    
    var body: some View {
        VStack {
            NavigationStack {
                TextEditor(text: $notes)
                    .navigationTitle("Notes")
                    .padding()
            }
            
            NavigationStack {
                List(students) { student in
                    Text(student.name)
                }
                .navigationTitle("Classroom")
                .toolbar {
                    Button("Add") {
                        let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                        let lastNames = ["Weasley", "Granger", "Lovegood", "Potter"]
                        
                        let chosenFirstName = firstNames.randomElement()!
                        let chosenLastName = lastNames.randomElement()!
                        
                        let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                        modelContext.insert(student)
                    }
                }
            }
            
            // We pass a binding of a state variable to continously update the value rememberMe via PushButton's @Binding
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On":"Off")
        }
    }
}

#Preview {
    PracticeView()
}

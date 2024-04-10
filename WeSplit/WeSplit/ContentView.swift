//
//  ContentView.swift
//  WeSplit
//
//  Created by Marco Capraro on 4/10/24.
//

import SwiftUI

/* 
This file contains the initial user interface (UI)
for your program, and is where we’ll be doing all
the work in this project.
*/
struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent: String = "Harry"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) { student in
                        Text("\(student)")
                    }
                }
            }
            .navigationTitle("Select a Student")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}

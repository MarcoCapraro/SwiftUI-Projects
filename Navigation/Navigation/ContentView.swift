//
//  ContentView.swift
//  Navigation
//
//  Created by Marco Capraro on 5/16/24.
//

import SwiftUI

struct Student: Hashable {
    let id = UUID()
    let name: String
    let age: Int
}

struct DetailView: View {
    var number: Int
    
    init(number: Int) {
        self.number = number
        print("Creating DetailView")
    }
    
    var body: some View {
        Text("\(number)")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .navigationDestination(for: Student.self) { student in
                Text("You selected \(student.name)")
            }
        }
    }
}

#Preview {
    ContentView()
}

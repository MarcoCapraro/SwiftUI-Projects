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
    @State private var path = [Int]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Show 32") {
                    path = [32]
                }
                
                Button("Show 64") {
                    path.append(64)
                }
                
                Button("Show 64 then 32") {
                    path = [32, 64]
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

#Preview {
    ContentView()
}

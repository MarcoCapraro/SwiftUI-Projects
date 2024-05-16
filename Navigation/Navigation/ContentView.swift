//
//  ContentView.swift
//  Navigation
//
//  Created by Marco Capraro on 5/16/24.
//

import SwiftUI

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
            List(0..<1000) { i in
                NavigationLink("Tap Me") {
                    DetailView(number: i)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

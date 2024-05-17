//
//  ContentView.swift
//  Navigation
//
//  Created by Marco Capraro on 5/16/24.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List(0..<100) { i in
                    NavigationLink("Row \(i)") {
                        Text("Detail View")
                    }
                }
                .navigationTitle("Title Customization")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.blue)
                .toolbarColorScheme(.dark)
                // .toolbar(.hidden, for: .navigationBar)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("B1") {}
                    Button("B2") {}
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button("Tap Me") {}
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  MoonShot
//
//  Created by Marco Capraro on 5/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
                 
    var body: some View {
        NavigationStack {
            Group {
                if isShowingGrid {
                    GridLayoutView(missions: missions, astronauts: astronauts)
                } else {
                    ListLayoutView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Toggle Layout", systemImage: "togglepower") {
                        isShowingGrid.toggle()
                    }
                    .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

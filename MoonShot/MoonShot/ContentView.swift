//
//  ContentView.swift
//  MoonShot
//
//  Created by Marco Capraro on 5/13/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text("Hello World")
        
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  MoonShot
//
//  Created by Marco Capraro on 5/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(.tron)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { size, axis in
                size * 0.8
            }
    }
}

#Preview {
    ContentView()
}

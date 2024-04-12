//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Marco Capraro on 4/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                HStack {
                    Text("1")
                    Text("2")
                    Text("3")
                }
                HStack {
                    Text("4")
                    Text("5")
                    Text("6")
                }
                HStack {
                    Text("7")
                    Text("8")
                    Text("9")
                }
            }
            
            VStack(alignment: .center) {
                HStack {
                    Text("11")
                    Text("2")
                    Text("3")
                }
                HStack {
                    Text("44")
                    Text("5")
                    Text("6")
                }
                HStack {
                    Text("77")
                    Text("8")
                    Text("9")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

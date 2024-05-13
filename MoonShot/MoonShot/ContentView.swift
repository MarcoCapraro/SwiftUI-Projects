//
//  ContentView.swift
//  MoonShot
//
//  Created by Marco Capraro on 5/13/24.
//

import SwiftUI

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(text: String) {
        print("Creating new CustomText")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        
        
        
        NavigationStack {
            Image(.tron)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.8
                }
            
            List(0..<100) { row in
                NavigationLink("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
            .navigationTitle("SwiftUI")
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<100) {
                        CustomText(text: "Item \($0)")
                            .font(.title)
                    }
                }
            }
        }
        
        
        
        
        
    }
}

#Preview {
    ContentView()
}

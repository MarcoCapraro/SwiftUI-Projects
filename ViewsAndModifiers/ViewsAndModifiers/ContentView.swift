//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Marco Capraro on 4/17/24.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 20))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

struct GridStack<Content:View>: View {
    let rows: Int
    let cols: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<cols, id: \.self) { col in
                        content(row, col)
                    }
                }
            }
        }
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func waterMark(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    @State private var isOn = false
    
    @ViewBuilder var motto1: some View {
        Text("The Golden Rule")
    }
    
    let motto2 = Text("Honesty is the best policy")
    
    var body: some View {
        VStack {
            Spacer()
            Button("Hellow World") {
                isOn.toggle()
            }
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(.background)
            .padding()
            .background(.primary)
            
            VStack {
                CapsuleText(text: "Capsule Text")
                Text("Title Text")
                    .titleStyle()
                Text("Watermark Text")
                    .frame(width: 300, height: 200)
                    .background(.white)
                    .waterMark(with: "Signed Marco Capraro")

                Spacer()
                
                GridStack(rows: 4, cols: 4) { row, col in
                    Text("[\(row),\(col)]")
                }
                .padding()
                .background(.white)
                
                Spacer()
                motto1
                motto2
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isOn ? .green : .red)
    }
}

#Preview {
    ContentView()
}

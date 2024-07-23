//
//  ConfirmationDialogView.swift
//  InstaFilter
//
//  Created by Marco Capraro on 7/23/24.
//

import SwiftUI

struct ConfirmationDialogView: View {
    @State private var blurAmount = 0.0
//      Doesn't work with slider binded value, need to write onChange function
//        didSet {
//            print("New Value is \(blurAmount)")
//        }
    
    @State private var showConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        VStack {
            
            VStack {
                Text("Hello, world!")
                    .blur(radius: blurAmount)
                
                Slider(value: $blurAmount, in: 0...20)
                    .onChange(of: blurAmount) { oldValue, newValue in
                        print("New Value is \(blurAmount)")
                    }
                
                
                Button("Random Blur") {
                    blurAmount = Double.random(in: 0...20)
                }
            }
            
            Spacer()
            
            VStack {
                Button("Hello World") {
                    showConfirmation.toggle()
                }
                .frame(width: 300, height: 300)
                .background(backgroundColor)
                .clipShape(.capsule)
                .confirmationDialog("Change Background", isPresented: $showConfirmation) {
                    Button("Red") { backgroundColor = .red }
                    Button("Green") { backgroundColor = .green }
                    Button("Blue") { backgroundColor = .blue }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Select a new color")
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ConfirmationDialogView()
}

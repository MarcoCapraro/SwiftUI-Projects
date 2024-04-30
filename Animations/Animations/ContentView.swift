//
//  ContentView.swift
//  Animations
//
//  Created by Marco Capraro on 4/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationScale = 1.0
    @State private var animationPulse = 1.0
    @State private var animationAmount = 0.0
    
    @State private var enabled1 = false
    @State private var enabled2 = false
    @State private var enabled3 = false
    
    @State private var dragAmount1 = CGSize.zero
    @State private var dragAmount2 = CGSize.zero
    
    @State private var isShowingCircle = false
    
    let letters = Array("Drag Me Around!")
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Stepper("Scale Amount", value: $animationScale.animation(), in: 1...2, step: 0.25)
                    .frame(maxWidth: 175)
                    .padding(20)
                    .foregroundStyle(.black)
                    .clipShape(.rect(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 5)
                            .scaleEffect(animationPulse)
                            .opacity(1.5 - animationPulse)
                            .animation(
                                .easeOut(duration: 1.0)
                                .repeatForever(autoreverses: false),
                                value: animationPulse
                            )
                    )
                    .onAppear {
                        animationPulse = 1.5
                    }
                
                Button("Tap Me") {
                    enabled1.toggle()
                }
                .frame(maxWidth: 100, maxHeight: 100)
                .background(enabled1 ? .blue : .red)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: enabled1 ? 60: 0))
                .animation(.default, value: enabled1)
                .padding(50)
                
                Button("Spin Me") {
                    animationScale == 2.0 ? (animationScale = 1) : (animationScale += 0.25)
                    withAnimation(.spring(duration: 1, bounce: 0.8)) {
                        animationAmount += 360
                    }
                }
                .padding(25)
                .background(.black)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .rotation3DEffect(.degrees(animationAmount), axis: (x: -1.0, y: 0.0, z: 0.0))
                .scaleEffect(animationScale)
                .blur(radius: 2.0 * (1 / animationScale))
                .animation(
                    .spring(duration: 0.5, bounce: 0.75),
                    value: animationScale
                )
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 45)
            .background(LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottom))
                        
            VStack {
                
                Button("???") {
                    withAnimation {
                        isShowingCircle.toggle()
                    }
                }
                .frame(maxWidth: 50, maxHeight: 50)
                .background(.gray)
                .foregroundStyle(.white)
                .border(.white)
                
                if isShowingCircle {
                    Circle()
                        .fill(LinearGradient(colors: [.yellow, .orange], startPoint: .bottomLeading, endPoint: .topTrailing))
                        .frame(maxWidth: 100, maxHeight: 100)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    ForEach(0..<letters.count, id: \.self) { num in
                        Text(String(letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(enabled3 ? .blue : .green)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .offset(dragAmount2)
                            .animation(.linear.delay(Double(num) / 20), value: dragAmount2)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount2 = $0.translation }
                        .onEnded { _ in
                            dragAmount2 = .zero
                            enabled3.toggle()
                        }
                )
                
                Spacer()
                
                LinearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(maxWidth: 150, maxHeight: 100)
                    .clipShape(.rect(cornerRadius: 20))
                    .offset(dragAmount1)
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount1 = $0.translation }
                            .onEnded { _ in
                                withAnimation(.bouncy) {
                                    dragAmount1 = .zero
                                }
                            }
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [.gray, .black], startPoint: .top, endPoint: .bottom))
            
        }
    }
}

#Preview {
    ContentView()
}

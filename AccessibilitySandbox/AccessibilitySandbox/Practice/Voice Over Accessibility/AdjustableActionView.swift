//
//  AdjustableActionView.swift
//  AccessibilitySandbox
//
//  Created by Marco Capraro on 8/26/24.
//

import SwiftUI

struct AdjustableActionView: View {
    @State private var value = 10
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Value: \(value)")
            Button("Increment") {
                value += 1
            }
            
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not Handled")
            }
        }
    }
}

#Preview {
    AdjustableActionView()
}

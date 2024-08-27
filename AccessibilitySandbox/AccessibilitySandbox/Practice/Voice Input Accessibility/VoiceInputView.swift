//
//  VoiceInputView.swift
//  AccessibilitySandbox
//
//  Created by Marco Capraro on 8/27/24.
//

import SwiftUI

struct VoiceInputView: View {
    
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
    }
}

#Preview {
    VoiceInputView()
}

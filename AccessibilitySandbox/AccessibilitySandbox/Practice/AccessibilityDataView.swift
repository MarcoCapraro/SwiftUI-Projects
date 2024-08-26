//
//  AccessibilityDataView.swift
//  AccessibilitySandbox
//
//  Created by Marco Capraro on 8/26/24.
//

import SwiftUI

struct AccessibilityDataView: View {
    
    var body: some View {
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
    }
}

#Preview {
    AccessibilityDataView()
}

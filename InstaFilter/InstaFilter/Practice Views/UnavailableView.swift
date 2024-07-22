//
//  UnavailableView.swift
//  InstaFilter
//
//  Created by Marco Capraro on 7/22/24.
//

import SwiftUI

struct UnavailableView: View {
    var body: some View {
        VStack {
            ContentUnavailableView {
                Label("No snippets", systemImage: "swift")
            } description: {
                Text("You don't have any saved snippets yet.")
            } actions: {
                Button("Create a snippet") {
                    // create a snippet
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    UnavailableView()
}

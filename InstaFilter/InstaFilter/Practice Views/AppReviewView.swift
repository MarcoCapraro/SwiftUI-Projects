//
//  AppReviewView.swift
//  InstaFilter
//
//  Created by Marco Capraro on 7/23/24.
//

import StoreKit
import SwiftUI

struct AppReviewView: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Leave a Review") {
            // Try to do this when user has performed some action a set amount of times within the app
            requestReview()
        }
    }
}

#Preview {
    AppReviewView()
}

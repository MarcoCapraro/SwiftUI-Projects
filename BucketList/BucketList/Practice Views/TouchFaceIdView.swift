//
//  TouchFaceIdView.swift
//  BucketList
//
//  Created by Marco Capraro on 7/31/24.
//

import LocalAuthentication
import SwiftUI

struct TouchFaceIdView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, authenticationError in
                if success {
                   // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem (make sure to have a backup plan)
                    // maybe an alert
                }
                
            }
        } else {
            // no biometrics
        }
    }
}

#Preview {
    TouchFaceIdView()
}

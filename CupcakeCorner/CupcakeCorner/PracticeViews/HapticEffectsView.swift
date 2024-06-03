//
//  HapticEffectsView.swift
//  CupcakeCorner
//
//  Created by Marco Capraro on 6/3/24.
//

import CoreHaptics
import SwiftUI

struct HapticEffectsView: View {
    @State private var counter1 = 0
    @State private var counter2 = 0
    @State private var engine: CHHapticEngine?
    
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Tap First Counter \(counter1)") {
                counter1 += 1
            }
            .sensoryFeedback(.increase, trigger: counter1)
            
            Button("Tap Second Counter \(counter2)") {
                counter2 += 1
            }
            .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter2)
            
            Button("Play Complex Success Haptic", action: complexSuccess)
                .onAppear(perform: prepareHaptics)
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, through: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, through: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    HapticEffectsView()
}

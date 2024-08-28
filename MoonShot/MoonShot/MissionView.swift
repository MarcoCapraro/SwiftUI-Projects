//
//  MissionView.swift
//  MoonShot
//
//  Created by Marco Capraro on 5/15/24.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            // Astronaut exists in mission crew and in dictionary of astronauts then return CrewMember
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.6
                        }
                    
                    // Add launch date underneath mission badge
                    Text("\(mission.missionFormattedDate)")
                        .font(.title3.bold())
                        .padding(.top)
                        .lineLimit(1)
                }
                .accessibilityElement()
                .accessibilityLabel("\(mission.displayName) \((mission.missionFormattedDate != "Launch Failure" ? "Launch Date: \(mission.missionFormattedDate)" : "Launch Failure"))")
                
                MissionDetailView(mission: mission, crew: crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

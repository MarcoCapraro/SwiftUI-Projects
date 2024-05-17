//
//  ListLayoutView.swift
//  MoonShot
//
//  Created by Marco Capraro on 5/15/24.
//

import SwiftUI

struct ListLayoutView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    HStack() {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 50)
                        
                        VStack(alignment: .leading) {
                            Text("\(mission.displayName)")
                                .font(.headline)
                            Text("\(mission.formattedLaunchDate)")
                                .font(.caption)
                        }
                    }
                }
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
            }
            .listRowBackground(Color.darkBackground)
            
        }
        .listStyle(.plain)
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return ListLayoutView(missions: missions, astronauts: astronauts)
}

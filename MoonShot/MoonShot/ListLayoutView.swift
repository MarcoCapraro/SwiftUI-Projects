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
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
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
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return ListLayoutView(missions: missions, astronauts: astronauts)
}

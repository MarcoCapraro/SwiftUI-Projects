//
//  Mission.swift
//  MoonShot
//
//  Created by Marco Capraro on 5/14/24.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
    
    // Can make this a nested struct since it's made specifically for Mission
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var missionFormattedDate: String {
        launchDate?.formatted(date: .complete, time: .omitted) ?? "Launch Failure"
    }
}

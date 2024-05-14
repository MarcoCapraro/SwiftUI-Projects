//
//  Mission.swift
//  MoonShot
//
//  Created by Marco Capraro on 5/14/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    // Can make this a nested struct since it's made specifically for Mission
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}

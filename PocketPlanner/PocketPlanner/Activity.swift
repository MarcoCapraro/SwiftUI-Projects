//
//  Activity.swift
//  PocketPlanner
//
//  Created by Marco Capraro on 5/20/24.
//

import SwiftUI

struct Activity: Hashable, Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var date: String
    var time: String
    var tag: String
}

//
//  Job.swift
//  SwiftDataProject
//
//  Created by Marco Capraro on 7/16/24.
//

import SwiftData
import Foundation

@Model
class Job {
    var name: String
    var priority: Int
    var owner: User?
    
    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}

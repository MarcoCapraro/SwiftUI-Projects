//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Marco Capraro on 7/12/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}

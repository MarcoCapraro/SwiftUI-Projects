//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Marco Capraro on 6/6/24.
//

import SwiftData
import SwiftUI

// This property wrapper tells our app to launch our application from here
@main
struct BookWormApp: App {
    var body: some Scene {
        // This tells SwiftUI app to be multi-windowed
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Student.self)
    }
}

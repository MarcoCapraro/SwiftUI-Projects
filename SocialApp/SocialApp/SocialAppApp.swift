//
//  SocialAppApp.swift
//  SocialApp
//
//  Created by Marco Capraro on 7/17/24.
//

import SwiftData
import SwiftUI

@main
struct SocialAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}

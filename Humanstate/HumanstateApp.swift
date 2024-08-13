//
//  HumanstateApp.swift
//  Humanstate
//
//  Created by Noah Sadat on 25.07.24.
//

import SwiftUI
import SwiftData

@main
struct HumanstateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [BodyTask.self, MindTask.self])
    }
}

//
//  GatherlyApp.swift
//  Gatherly
//
//  Created by James Ellis on 2/5/26.
//

import SwiftUI
import SwiftData

@main
struct GatherlyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: RSVPedEvent.self)
    }
}

//
//  C2App.swift
//  C2
//
//  Created by 이은지 on 4/19/26.
//

import SwiftUI
import SwiftData

@main
struct C2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Quest.self)
    }
}

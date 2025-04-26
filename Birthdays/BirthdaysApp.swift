//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Valerie Hammer on 4/25/25.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}

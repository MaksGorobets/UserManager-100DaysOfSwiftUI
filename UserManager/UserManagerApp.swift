//
//  UserManagerApp.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import SwiftUI
import SwiftData

@main
struct UserManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}

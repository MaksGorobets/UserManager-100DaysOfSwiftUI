//
//  PreviewData.swift
//  UserManager
//
//  Created by Maks Winters on 23.12.2023.
//

import Foundation
import SwiftData

@MainActor
class DataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: User.self, configurations: config)

            let user = createUser()
            container.mainContext.insert(user)

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}

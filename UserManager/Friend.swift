//
//  Friend.swift
//  UserManager
//
//  Created by Maks Winters on 23.12.2023.
//

import Foundation
import SwiftData

@Model
class Friend: Codable, Hashable, Identifiable {
    
    var id: UUID
    var name: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

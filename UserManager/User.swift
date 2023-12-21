//
//  User.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    
    struct Friend: Codable, Hashable, Identifiable {
        var id: UUID
        var name: String
    }
    
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}

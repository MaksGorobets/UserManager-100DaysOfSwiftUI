//
//  User.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import Foundation
import SwiftData

@Model
class User: Codable, Identifiable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
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
    @Relationship(deleteRule: .cascade) var friends: [Friend]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }
}

class UserDictionary {
    var dictionary: [UUID: User] = [:]
    
    func createDictionary(users: [User]) {
        print("Creating users dictionary")
        for user in users {
            dictionary[user.id] = user
        }
    }
}

//struct ExampleStruct: Codable {
//    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//    }
//    
//    var name: String
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.name, forKey: .name)
//    }
//}

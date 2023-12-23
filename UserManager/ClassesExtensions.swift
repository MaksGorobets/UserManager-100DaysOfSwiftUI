//
//  ClassesExtensions.swift
//  UserManager
//
//  Created by Maks Winters on 23.12.2023.
//

import Foundation

extension User {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isActive = "isActive"
        case name = "name"
        case age = "age"
        case company = "company"
        case email = "email"
        case address = "address"
        case about = "about"
        case registered = "registered"
        case tags = "tags"
        case friends = "friends"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.self, forKey: .id)
        try container.encode(isActive.self, forKey: .isActive)
        try container.encode(name.self, forKey: .name)
        try container.encode(age.self, forKey: .age)
        try container.encode(company.self, forKey: .company)
        try container.encode(email.self, forKey: .email)
        try container.encode(address.self, forKey: .address)
        try container.encode(about.self, forKey: .about)
        try container.encode(registered.self, forKey: .registered)
        try container.encode(tags.self, forKey: .tags)
        try container.encode(friends.self, forKey: .friends)
    }
}

extension Friend {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.self, forKey: .id)
        try container.encode(name.self, forKey: .name)
    }

    
}

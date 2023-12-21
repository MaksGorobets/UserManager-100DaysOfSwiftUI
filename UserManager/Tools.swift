//
//  Tools.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import Foundation

func isUserActive(_ providedUser: User) -> String {
    if providedUser.isActive {
        return "active"
    } else {
        return "not active"
    }
}

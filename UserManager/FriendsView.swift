//
//  FriendsView.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import SwiftUI

struct FriendsView: View {
    
    let friends: [User.Friend]
    
    var body: some View {
        List(friends) { friend in
            Text(friend.name)
        }
    }
}

#Preview {
    FriendsView(friends: [User.Friend(id: UUID(uuidString: "A706B8B7-7495-4FF8-BF75-679BA2AB2271") ?? UUID(), name: "Some guy")])
}

//
//  FriendsView.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import SwiftUI

struct FriendsView: View {
    
    let friends: [User.Friend]
    let users: [UUID: User]
    
    var body: some View {
        List(friends) { friend in
            NavigationLink(value: userForFriend(friend: friend)) {
                HStack {
                    Image(systemName: "person")
                    Text(friend.name)
                }
            }
            .navigationTitle("Friends")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func userForFriend(friend: User.Friend) -> User? {
        guard let userFriend = users[friend.id] else { return nil }
        return userFriend
    }
    
}

#Preview {
    let user = createUser()
    return FriendsView(friends: [User.Friend(id: UUID(uuidString: "A706B8B7-7495-4FF8-BF75-679BA2AB2271") ?? UUID(), name: "Some guy")], users: [user.id : user])
}

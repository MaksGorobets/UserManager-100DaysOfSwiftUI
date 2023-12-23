//
//  FriendsView.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import SwiftUI
import SwiftData

struct FriendsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    let friends: [Friend]
    var userDictionary: UserDictionary
    
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
    
    func userForFriend(friend: Friend) -> User? {
        guard let userFriend = userDictionary.dictionary[friend.id] else { return nil }
        return userFriend
    }
    
}

#Preview {
    let user = createUser()
    return FriendsView(friends: user.friends, userDictionary: UserDictionary())
}

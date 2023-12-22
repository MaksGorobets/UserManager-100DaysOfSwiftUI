//
//  UserDetailView.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import SwiftUI

struct UserDetailView: View {
    
    let users: [UUID: User]
    
    let user: User
    
    @Binding var path: NavigationPath
    
    var body: some View {
        List {
            Section("General") {
                General(user: user)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                                .padding(10)
                                .foregroundStyle(.white)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            Section("Details") {
                Text("Adress: \(user.address)")
                Text("Email: \(user.email)")
            }
            Section("About") {
                Text(user.about)
            }
            NavigationLink(value: user.friends) {
                Text("Friends")
            }
            .navigationDestination(for: [User.Friend].self) { friends in
                FriendsView(friends: friends, users: users)
            }
            .toolbar {
                Button("Back to root") {
                    path = NavigationPath()
                }
            }
        }
        .navigationTitle("User details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct General: View {
    
    let user: User
    
    var body: some View {
        HStack {
            Image(.nopp)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(user.name)
                Group {
                    Text("\(user.company), \(isUserActive(user))")
                    Text("Age: \(user.age)")
                }
                .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    let user = createUser()
    let path = NavigationPath()
    return UserDetailView(users: [user.id : user], user: createUser(), path: .constant(path))
}

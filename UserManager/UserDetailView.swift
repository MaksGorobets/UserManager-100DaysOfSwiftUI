//
//  UserDetailView.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import SwiftUI
import SwiftData

struct UserDetailView: View {
    
    let user: User
    let colors = [Color.orange, Color.green, Color.blue, Color.purple, Color.red]
    
    @Binding var path: NavigationPath
    
    var userDictionary: UserDictionary
    
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
                                .background(LinearGradient(colors: [colors.randomElement() ?? .blue, .black], startPoint: .bottomLeading, endPoint: .topTrailing))
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
            .navigationDestination(for: [Friend].self) { friends in
                FriendsView(friends: friends, userDictionary: userDictionary)
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
        LazyHStack {
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
        .padding(.vertical)
    }
}

#Preview {
    let user = createUser()
    let path = NavigationPath()
    return UserDetailView(user: user, path: .constant(path), userDictionary: UserDictionary())
}

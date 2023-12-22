//
//  ContentView.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users = [UUID: User]()
    @State var path = NavigationPath()
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(Array(users.values), id: \.self) { user in
                    NavigationLink(value: user) {
                        General(user: user)
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(users: users, user: user, path: $path)
            }
            .alert("There was an error...", isPresented: $showingAlert) {
                Text(alertMessage)
                Button("OK") { }
            }
            .task {
                do {
                    try await fetchUsers()
                } catch {
                    print(error)
                }
            }
            .navigationTitle("Users")
        }
    }
    
    func fetchUsers() async throws {
        guard users.isEmpty else {
            print("The array is not empty")
            return
        }
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            throw NetworkError.invalidURL
        }
        print("Starting a do-block")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode([User].self, from: data)
            print(decoded)
            
            for single in decoded {
                print("Adding \(single.id)")
                let id = single.id
                let user = single
                users[id] = user
            }
            
        } catch {
            alertMessage = error.localizedDescription
            showingAlert = true
        }
    }
}


#Preview {
    ContentView()
}

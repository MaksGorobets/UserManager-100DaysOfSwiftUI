//
//  ContentView.swift
//  UserManager
//
//  Created by Maks Winters on 21.12.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var users: [User]
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @State private var path = NavigationPath()
    var userDictionary = UserDictionary()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(users, id: \.self) { user in
                    NavigationLink(value: user) {
                        General(user: user)
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user, path: $path, userDictionary: userDictionary)
            }
            .toolbar {
                Button("Refresh") {
                    Task {
                        await refresh()
                    }
                    createDictionary()
                }
            }
            .alert("There was an error...", isPresented: $showingAlert) {
                Text(alertMessage)
                Button("OK") { }
            }
            .task {
                do {
                    try await fetchUsers()
                    createDictionary()
                } catch {
                    print(error)
                }
            }
            .navigationTitle("Users")
        }
    }
    
    @MainActor func refresh() async {
        do {
            try modelContext.delete(model: User.self)
        } catch {
            showError(error: error)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            Task {
                userDictionary.dictionary = [:]
                try await fetchUsers()
                createDictionary()
            }
        }
    }
    
    @MainActor  func createDictionary() {
        if userDictionary.dictionary.isEmpty {
            userDictionary.createDictionary(users: users)
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
        print("Starting a fetch do-block")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode([User].self, from: data)
            
            await insertArray(users: decoded)
            
        } catch {
            showError(error: error)
        }
    }
    
    @MainActor func insertArray(users: [User]) {
        withAnimation {
            for user in users {
                modelContext.insert(user)
            }
        }
    }
    
    func showError(error: Error) {
        alertMessage = error.localizedDescription
        showingAlert = true
    }
    
}


#Preview {
    ContentView()
        .modelContainer(DataController.previewContainer)
}

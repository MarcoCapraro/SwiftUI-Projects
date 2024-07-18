//
//  ContentView.swift
//  SocialApp
//
//  Created by Marco Capraro on 7/17/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
        
    var body: some View {
        NavigationStack {
            List(users, id:\.id) { user in
                NavigationLink(value: user) {
                    HStack(alignment: .center) {
                        Text(user.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        HStack(spacing: 0) {
                            Text("Status: ")
                                .frame(maxWidth: .infinity, alignment: .trailing)

                            Text(user.status)
                                .foregroundStyle(user.onOffColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
            .navigationTitle("All Users")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            // Empty SwiftData modelContext for stored Users
            // try? modelContext.delete(model: User.self)
            
            guard users.isEmpty else {
                return
            }
            
            let loadedUsers = await loadData()
            for user in loadedUsers {
                modelContext.insert(user)
            }
        }
    }
    
    func loadData() async -> [User] {
        var results: [User] = []
        
        // Create URL
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return results
        }
        
        // Fetch data for URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode result of data into [User] class
            if let decodedData = try? JSONDecoder().decode([User].self, from: data) {
                results = decodedData
            }
            
        } catch {
            print("Invalid Data")
            return results
        }
        
        return results
    }
}

#Preview {
     ContentView()
}

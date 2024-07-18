//
//  UserDetailView.swift
//  SocialApp
//
//  Created by Marco Capraro on 7/17/24.
//

import SwiftData
import SwiftUI

struct UserDetailView: View {
    @Environment(\.modelContext) var modelContext
    var user: User
    
    var body: some View {
        
        Form {
            Section("About") {
                Text(user.about)
            }
            
            Section("Background") {
                Text("Age: \(user.age)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("Company: \(user.company)")
                Text("Tags: \(user.tags.joined(separator: ", "))")
            }
            
            Section("Friends") {
                List(user.friends, id:\.id) { friend in
                    Text(friend.name)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(user.name)
                        .font(.title2.weight(.black))
                    
                    HStack(spacing: 0) {
                        Text("Status: ")
                        Text(user.status)
                            .foregroundStyle(user.onOffColor)
                            .fontWeight(.bold)
                    }
                    .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let example = User(id: "6j4h3k59fd983k2-fehu21234k", isActive: true, name: "Marco Capraro", age: 25, company: "Unemployed", email: "macapr@gmail.com", address: "44552 Water Court", about: "This is a random about section to showcase placeholder data to see what the UserDetailView will look like with stored User information", registered: "", tags: ["tag1", "tag2", "tag3", "tag4", "tag5"], friends: [])
        
        return UserDetailView(user: example)
            .modelContainer(container)
    } catch {
        return Text("Failed Preview: \(error.localizedDescription)")
    }
}

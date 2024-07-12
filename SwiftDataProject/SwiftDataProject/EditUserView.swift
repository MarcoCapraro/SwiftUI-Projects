//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Marco Capraro on 7/12/24.
//

import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let modelConfig = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: User.self, configurations: modelConfig)
        let example = User(name: "Marco", city: "Rockville", joinDate: Date.now)
        
        return EditUserView(user: example)
            .modelContainer(modelContainer)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}

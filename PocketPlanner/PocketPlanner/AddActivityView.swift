//
//  AddActivityView.swift
//  PocketPlanner
//
//  Created by Marco Capraro on 5/21/24.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @State private var activityTitle: String = "Activity Title"
    @State private var activityDescription: String = ""
    @State private var activityTag: String = "🏋️"
    
    let tags = ["🏋️", "🧘", "🏊", "🎟️", "🚴", "🎨", "🎼", "🎮", "📖", "⚽️", "🏃‍♂️‍➡️", "🧑‍🍳", "🧑‍💻"]
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Description", text: $activityDescription, axis: .vertical)
                        .lineLimit(5...10)
                    Picker("Tags", selection: $activityTag) {
                        ForEach(tags, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle($activityTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        let nowDate = String(Date.now.formatted(date: .abbreviated, time: .omitted))
                        let nowTime = String(Date.now.formatted(date: .omitted, time: .shortened))
                        let newActivity = Activity(title: activityTitle, description: activityDescription, date: nowDate, time: nowTime, tag: activityTag, completionCount: 0)
                        
                        activities.activities.append(newActivity)
                        dismiss()
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}

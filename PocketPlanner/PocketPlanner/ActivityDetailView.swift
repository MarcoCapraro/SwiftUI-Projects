//
//  ActivityDetailView.swift
//  PocketPlanner
//
//  Created by Marco Capraro on 5/22/24.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.dismiss) var dismiss
    var plans: Activities
    var activity: Activity
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(activity.description)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding([.horizontal, .vertical], 50)
                    .borderStyle(color: .white)
                            
                HStack {
                    Text("Completed: \(activity.completionCount) Times")
                        .font(.title2)
                        .frame(maxHeight: 100)
                    
                    HStack(alignment: .center) {
                        Button("", systemImage: "minus") {
                            var newActivity = activity
                            newActivity.completionCount = max(activity.completionCount - 1, 0)
                            if let index = plans.activities.firstIndex(of: activity) {
                                plans.activities[index] = newActivity
                            }
                        }
                        Button("", systemImage: "plus") {
                            var newActivity = activity
                            newActivity.completionCount = activity.completionCount + 1
                            if let index = plans.activities.firstIndex(of: activity) {
                                plans.activities[index] = newActivity
                            }
                        }
                    }
                    .padding(10)
                    .foregroundStyle(.black)
                    .background(Color.lightGray)
                    .clipShape(.rect(cornerRadius: 5))
                    .borderStyle(color: Color.white)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
            .navigationTitle(activity.title)
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text(activity.tag)
                        .font(.system(size: 100))
                        .frame(maxWidth: .infinity, maxHeight: 100)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ActivityDetailView(plans: Activities(), activity: Activity(title: "Title", description: "descriptions", date: "May 22, 2024", time: "4:36", tag: "🏋️", completionCount: 0))
}

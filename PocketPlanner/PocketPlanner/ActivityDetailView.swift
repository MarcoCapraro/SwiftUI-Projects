//
//  ActivityDetailView.swift
//  PocketPlanner
//
//  Created by Marco Capraro on 5/22/24.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.dismiss) var dismiss
    var activity: Activity
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(activity.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .vertical], 50)
                
                Spacer()
            }
            .navigationTitle(activity.title)
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text(activity.tag)
                        .font(.system(size: 100))
                        .padding(.bottom, 50)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ActivityDetailView(activity: Activity(title: "Title", description: "descriptions", date: "May 22, 2024", time: "4:36", tag: "🏋️"))
}

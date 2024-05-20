//
//  ContentView.swift
//  PocketPlanner
//
//  Created by Marco Capraro on 5/20/24.
//

import SwiftUI

struct BorderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay {
                Rectangle()
                    .stroke(.black, lineWidth: 2)
            }
    }
}

extension View {
    func borderStyle() -> some View {
        modifier(BorderStyle())
    }
}

struct ContentView: View {
    @State private var activities: [Activity] = [Activity(title: "Soccer Practice", description: "Follow Juventus Training Packet", date: "04/20/24", time: "3:40", tag: "Fitness"), Activity(title: "Tennis Practice", description: "Follow Juventus Training Packet", date: "04/20/24", time: "5:00", tag: "Fitness"), Activity(title: "Basketball Practice", description: "Follow Juventus Training Packet", date: "04/20/24", time: "12:30", tag: "Fitness")]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(activities, id: \.self) { activity in
                        NavigationLink {
                            Text("Detail View")
                        } label : {
                            HStack(spacing: 0) {
                                VStack(alignment: .leading) {
                                    Text(activity.title)
                                        .font(.title2.bold())
                                    Text("\(activity.date) @ \(activity.time)")
                                        .font(.title3)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                
                                // PlaceHolder for Activity Type
                                VStack(alignment: .center) {
                                    Text(activity.tag)
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                    Image(systemName: "clock")
                                        .resizable()
                                        .scaledToFit()
                                        .containerRelativeFrame(.horizontal) { width, axis in
                                            width * 0.1
                                        }
                                }
                                .frame(maxWidth: 100)
                                .padding(.bottom, 5)
                                .borderStyle()
                            }
                        }
                        .foregroundStyle(.black)
                    }
                    .onDelete(perform: removeItem)
                    .clipShape(.rect)
                    .borderStyle()
                    .padding(5)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Pocket Planning")
                        .font(.title.bold())
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Activity", systemImage: "plus") { }
                }
            }
            .preferredColorScheme(.light)
        }

    }
    
    func removeItem(at offsets: IndexSet) {
        activities.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

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
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.white, lineWidth: 2)
            }
    }
}

extension View {
    func borderStyle() -> some View {
        modifier(BorderStyle())
    }
}

@Observable
class Activities {
    var activities: [Activity]
    
    init(activities: [Activity]) {
        self.activities = activities
    }
}

struct ContentView: View {
    @State private var plans: Activities = Activities(activities: [Activity(title: "Soccer Practice", description: "Follow Juventus Training Packet", date: "04/20/24", time: "3:40", tag: "Fitness"), Activity(title: "Tennis Practice", description: "Follow Juventus Training Packet", date: "04/20/24", time: "5:00", tag: "Fitness"), Activity(title: "Basketball Practice", description: "Follow Juventus Training Packet", date: "04/20/24", time: "12:30", tag: "Fitness")])
    @State private var isShowingAdd = false
    

    
    var body: some View {
        NavigationStack {
            Form {
                List {
                    ForEach(plans.activities) { activity in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(activity.title)
                                    .font(.title2.bold())
                                    .lineLimit(1)
                                Text("\(activity.date) @ \(activity.time)")
                                    .font(.title3)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
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
                                    .padding(.bottom, 5)
                            }
                            .frame(maxWidth: 75)
                            .borderStyle()
                        }
                        .frame(maxHeight: 75)
                        .background(
                            NavigationLink("", destination: Text("Detail View"))
                                .opacity(0)
                        )
                    }
                    .onDelete(perform: removeItem)
                    .listRowBackground(Color.indigo)
                    .listRowSeparatorTint(.black)
                }
            }
            .sheet(isPresented: $isShowingAdd) {
                AddActivityView()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Pocket Planner")
                        .font(.title.bold())
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Activity", systemImage: "plus") { 
                        isShowingAdd.toggle()
                    }
                }
            }
            .preferredColorScheme(.dark)
        }

    }
    
    func removeItem(at offsets: IndexSet) {
        plans.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

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
    var activities: [Activity] {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.setValue(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "Activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                self.activities = decoded
                return
            }
        }
        
        self.activities = []
    }
}

struct ContentView: View {
    @State private var plans: Activities = Activities()
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
                                    .font(.system(size: 50, weight: .bold))
                                    .frame(maxWidth: .infinity)
                            }
                            .frame(maxWidth: 75)
                            .borderStyle()
                        }
                        .frame(maxHeight: 75)
                        .background(
                            NavigationLink("", destination: ActivityDetailView(activity: activity))
                                .opacity(0)
                        )
                    }
                    .onDelete(perform: removeItem)
                    .listRowBackground(Color.indigo)
                    .listRowSeparatorTint(.black)
                }
            }
            .sheet(isPresented: $isShowingAdd) {
                AddActivityView(activities: plans)
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

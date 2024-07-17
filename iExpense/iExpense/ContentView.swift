//
//  ContentView.swift
//  iExpense
//
//  Created by Marco Capraro on 5/8/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]
    
    @State private var sectionToShow = "All"
    @State private var isShowingAddView = false
        
    var body: some View {
        NavigationStack {
            List {
                ExpenseView(title: sectionToShow, sortOrder: sortOrder)                
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "plus")
                }
                
                Button("Showing \(sectionToShow)") {
                    if(sectionToShow == "All") {
                        sectionToShow = "Personal"
                    } else if (sectionToShow == "Personal") {
                        sectionToShow = "Business"
                    } else {
                        sectionToShow = "All"
                    }
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount)
                            ])
                        
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name)
                            ])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

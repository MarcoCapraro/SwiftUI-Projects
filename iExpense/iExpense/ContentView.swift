//
//  ContentView.swift
//  iExpense
//
//  Created by Marco Capraro on 5/8/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        // Whenever items is appended / deleted from, encode the new list
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personalItems: [ExpenseItem] {
            items.filter { $0.type == "Personal" }
        }
        
    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business" }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
}

struct ExpenseView: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                            .font(.subheadline)
                    }
                    
                    Spacer()

                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle((item.amount < 100) ? ((item.amount < 10) ? .gray : .orange) : .red)
                        .font(.headline.weight(.medium))
                        .underline()
                }
            }
            .onDelete(perform: deleteItems)
        }
        
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ExpenseView(title: "Personal", expenses: expenses.personalItems, deleteItems: removePersonalItems)
                ExpenseView(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems)
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    isShowingAddView = true
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
         var objectsToDelete = IndexSet()
         
         for offset in offsets {
             let item = inputArray[offset]
             
             if let index = expenses.items.firstIndex(of: item) {
                 objectsToDelete.insert(index)
             }
         }
         
         expenses.items.remove(atOffsets: objectsToDelete)
     }
     
     func removePersonalItems(at offsets: IndexSet) {
         removeItems(at: offsets, in: expenses.personalItems)
     }
     
     func removeBusinessItems(at offsets: IndexSet) {
         removeItems(at: offsets, in: expenses.businessItems)
     }
    
}

#Preview {
    ContentView()
}

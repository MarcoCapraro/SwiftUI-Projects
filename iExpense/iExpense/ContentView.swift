//
//  ContentView.swift
//  iExpense
//
//  Created by Marco Capraro on 5/8/24.
//

import SwiftUI

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
                NavigationLink {
                    AddView(expenses: expenses)
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "plus")
                }
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

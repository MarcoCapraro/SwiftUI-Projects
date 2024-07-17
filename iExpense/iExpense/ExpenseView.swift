//
//  ExpenseView.swift
//  iExpense
//
//  Created by Marco Capraro on 7/16/24.
//

import SwiftData
import SwiftUI

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    var title: String
    
    init(title: String, sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            title == "All" ||
            expense.type == title
        }, sort: sortOrder)
        
        self.title = title
    }
    
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
            .onDelete(perform: deleteExpense)
        }
    }
    
    func deleteExpense(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpenseView(title: "", sortOrder: [SortDescriptor(\Expense.name)])
}

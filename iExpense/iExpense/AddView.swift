//
//  AddView.swift
//  iExpense
//
//  Created by Marco Capraro on 5/9/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "Edit Title"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                // TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .padding(.leading)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let expense = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(expense)
                        dismiss()
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}

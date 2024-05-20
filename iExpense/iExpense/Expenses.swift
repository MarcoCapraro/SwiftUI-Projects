//
//  Expenses.swift
//  iExpense
//
//  Created by Marco Capraro on 5/20/24.
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

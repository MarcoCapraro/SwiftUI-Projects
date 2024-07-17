//
//  Expense.swift
//  iExpense
//
//  Created by Marco Capraro on 7/16/24.
//

import SwiftData
import Foundation

@Model
class Expense {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

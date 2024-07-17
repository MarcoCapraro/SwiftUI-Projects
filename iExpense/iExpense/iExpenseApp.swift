//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Marco Capraro on 5/8/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Expense.self)
        }
    }
}

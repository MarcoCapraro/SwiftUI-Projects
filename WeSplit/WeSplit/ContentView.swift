//
//  ContentView.swift
//  WeSplit
//
//  Created by Marco Capraro on 4/10/24.
//

import SwiftUI

/* 
This file contains the initial user interface (UI)
for your program, and is where we’ll be doing all
the work in this project.
*/
struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 20, 25, 0]
    var totalCheckAmount: Double {
        // Calculate total check amount with tip
        let tipPercent = Double(tipPercentage)
        let tipAmount = checkAmount * (tipPercent / 100.0)
        return checkAmount + tipAmount
    }
    
    var totalPerPerson: Double {
        // Calculate total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipPercent = Double(tipPercentage)
        
        let tipAmount = checkAmount * (tipPercent / 100.0)
        let totalCheck = checkAmount + tipAmount
        return totalCheck / peopleCount
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            if($0 % 5 == 0) { Text("\($0)%") }
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount (Check + Tip)") {
                    Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused { Button("Done") { amountIsFocused = false } }
            }
        }
    }
}

#Preview {
    ContentView()
}

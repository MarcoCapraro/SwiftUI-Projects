//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Marco Capraro on 5/31/24.
//

import SwiftUI



struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    Picker("Cupcake Type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) { i in
                            Text(Order.types[i])
                        }
                    }
                    
                    Stepper("Number of Cupcakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any Special Requests?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}

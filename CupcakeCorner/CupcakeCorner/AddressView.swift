//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Marco Capraro on 6/3/24.
//

import SwiftUI

struct AddressView: View {
    // @Bindable allows two way bindings for passed observable instance of order
    @Bindable var order: Order
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $order.name)
                    TextField("Street Address", text: $order.street)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }
                
                Section {
                    NavigationLink("Checkout") {
                        CheckoutView(order: order)
                    }
                }
                .disabled(order.hasValidAddress == false)
            }
        }
    }
}

#Preview {
    AddressView(order: Order())
}

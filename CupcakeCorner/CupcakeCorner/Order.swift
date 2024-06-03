//
//  Order.swift
//  CupcakeCorner
//
//  Created by Marco Capraro on 6/3/24.
//

import Foundation

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    
    var extraFrosting = false
    var addSprinkles = false
}

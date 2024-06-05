//
//  Order.swift
//  CupcakeCorner
//
//  Created by Marco Capraro on 6/3/24.
//

import Observation
import SwiftUI

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _street = "street"
        case _city = "city"
        case _zip = "zip"
    }
    
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
    
    var name = ""
    var street = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        
        // Make sure a string of pure whitespaces is invalid along with empty strings
        let nameEmpty = (name.trimmingCharacters(in: .whitespaces).count == 0) || name.isEmpty
        let streetEmpty = (street.trimmingCharacters(in: .whitespaces).count == 0) || street.isEmpty
        let cityEmpty = (city.trimmingCharacters(in: .whitespaces).count == 0) || city.isEmpty
        let zipEmpty = (zip.trimmingCharacters(in: .whitespaces).count == 0) || zip.isEmpty

        if nameEmpty || streetEmpty || cityEmpty || zipEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // Different flavor cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}

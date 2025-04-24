//
//  Order.swift
//  CupcakeCorner
//
//  Created by Rafael Badaró on 14/04/25.
//

import Foundation
import Observation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        return self.propertiesNotEmpty() && self.propertiesNotWhitespace()
    }
    
    private func propertiesNotEmpty() -> Bool {
        return !name.isEmpty
        && !streetAddress.isEmpty
        && !city.isEmpty
        && !zip.isEmpty
    }
    
    //MARK: Minhas solucao, com o allSatisfy
    private func propertiesNotWhitespace() -> Bool {
        return !name.allSatisfy { $0.isWhitespace }
        && !streetAddress.allSatisfy { $0.isWhitespace }
        && !city.allSatisfy { $0.isWhitespace }
        && !zip.allSatisfy { $0.isWhitespace }
    }
    
    //MARK: GPT + stackoverflow a titulo de curiosidade, sugeriram o trimmingCharacters
    private func propertiesNotWhitespaceTrimming() -> Bool {
        return !name.trimmingCharacters(in: .whitespaces).isEmpty
        && !streetAddress.trimmingCharacters(in: .whitespaces).isEmpty
        && !city.trimmingCharacters(in: .whitespaces).isEmpty
        && !zip.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
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
    
    func saveAddressToUserDefaults() {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(zip, forKey: "zip")
    }
}

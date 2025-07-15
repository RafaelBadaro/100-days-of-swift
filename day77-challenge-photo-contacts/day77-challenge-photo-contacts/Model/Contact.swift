//
//  Contact.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 14/07/25.
//

import Foundation
import UIKit

struct Contact: Identifiable, Codable, Hashable, Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name.lowercased() < rhs.name.lowercased()
    }
    
    var id = UUID()
    var name: String
    var image: Data
    
    var uiImage: UIImage? {
        return UIImage(data: self.image)
    }
}

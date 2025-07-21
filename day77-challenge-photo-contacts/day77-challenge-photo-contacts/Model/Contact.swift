//
//  Contact.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 14/07/25.
//

import Foundation
import MapKit
import UIKit

struct Contact: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var image: Data
    var latitude: Double?
    var longitude: Double?
    
    var coordinates: CLLocationCoordinate2D? {
          guard let latitude = latitude, let longitude = longitude else { return nil }
          return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      }
    
    var uiImage: UIImage? {
        return UIImage(data: self.image)
    }
    

}

extension Contact: Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name.lowercased() < rhs.name.lowercased()
    }
}

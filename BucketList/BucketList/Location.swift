//
//  Location.swift
//  BucketList
//
//  Created by Rafael Badaró on 13/06/25.
//

import Foundation
import MapKit

struct Location : Codable, Equatable, Identifiable {
    var id: UUID // Tem que ser colocado como "var" porque ele vai ser trocado na EditView
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    #if DEBUG
    static let example = Location(id: UUID(),
                                  name: "Buckingham palace",
                                  description: "Lit by over 40,000 lightbulbs.",
                                  latitude: 51.501,
                                  longitude: -0.141)
    #endif
}

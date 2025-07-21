//
//  EditContactView.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 14/07/25.
//

import MapKit
import SwiftUI

struct EditContactView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(DataManager.self) private var dataManager
    
    let contact: Contact
    @State private var showMap: Bool = false
    
    var body: some View {
        if let contactImage = contact.uiImage {
            VStack {
                Text("Name: \(contact.name)")
            
                Image(uiImage: contactImage)
                        .resizable()
                        .scaledToFit()
                
                if let coordinates = contact.coordinates {
                    Toggle(isOn: $showMap) {
                        Text("Show Map")
                    }.padding()
                    
                    if showMap {
                        mapView(for: coordinates)
                    }
                } else {
                    Text("Unfortunaley there are no coordinates for this contact :(")
                }
                
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button ("Delete contact"){
                        deleteContact()
                    }
                    .foregroundStyle(.red)
                }
            }
        } else {
            Text("Error in loading the contact Image")
        }
    }
    
    func deleteContact() {
        dataManager.deleteContact(id: contact.id)
        dismiss()
    }
}

extension EditContactView {
    private func mapView(for coordinates: CLLocationCoordinate2D) -> some View {
        Map(initialPosition:
                MapCameraPosition.region(
                    MKCoordinateRegion(center: coordinates,
                                       span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                ), interactionModes: []) {
                    Annotation(contact.name, coordinate: coordinates) {
                        Image(systemName: "mappin")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 20, height: 30)
                    }
                }
    }
}

#Preview {
    EditContactView(contact: Contact(id: UUID(), name: "Test", image: Data()))
        .environment(DataManager.shared)
}

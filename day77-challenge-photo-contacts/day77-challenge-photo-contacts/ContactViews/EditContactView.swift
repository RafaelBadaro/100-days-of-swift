//
//  EditContactView.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 14/07/25.
//

import SwiftUI

struct EditContactView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(DataManager.self) private var dataManager
    
    let contact: Contact
    
    var body: some View {
        if let contactImage = contact.uiImage {
            VStack {
                Image(uiImage: contactImage)
                    .resizable()
                    .scaledToFit()
    
                Text("Name: \(contact.name)")
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

#Preview {
    EditContactView(contact: Contact(id: UUID(), name: "Test", image: Data()))
        .environment(DataManager.shared)
}

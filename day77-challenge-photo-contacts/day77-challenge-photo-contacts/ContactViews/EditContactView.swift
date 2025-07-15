//
//  EditContactView.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 14/07/25.
//

import SwiftUI

struct EditContactView: View {
    @Environment(\.dismiss) var dismiss
    let contact: Contact
    @Binding var contacts: [Contact]
    
    var body: some View {
        if let contactImage = contact.uiImage {
            VStack {
                Image(uiImage: contactImage)
                    .resizable()
                    .scaledToFit()
                Text("Name: \(contact.name)")
            }
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
        contacts.removeAll { $0.id == contact.id }
        DataManager.save(contacts: contacts)
        dismiss()
    }
}

#Preview {
    EditContactView(contact: Contact(id: UUID(), name: "Test", image: Data()), contacts: .constant([]))
}

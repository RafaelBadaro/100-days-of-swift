//
//  EditView.swift
//  BucketList
//
//  Created by Rafael Badaró on 15/06/25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    var location: Location
    
    @State private var name: String
    @State private var description: String
    
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID() // Usado em conjunto com o "var id: UUID" da struct "Location"
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void){
        self.location = location
        self.onSave = onSave
        
       _name = State(wrappedValue: location.name)
       _description = State(wrappedValue: location.description)
    }
}

#Preview {
    EditView(location: .example) { _ in }
}

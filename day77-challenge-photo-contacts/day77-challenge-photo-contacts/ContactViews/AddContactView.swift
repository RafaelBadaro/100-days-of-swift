//
//  AddContactView.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 14/07/25.
//

import SwiftUI
import PhotosUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(DataManager.self) private var dataManager
        
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImageData: Data?

    @State private var name: String = ""
    
    var disableButton: Bool {
        selectedImageData == nil || name.isEmpty
    }
    
    // Propriedade computada pra mostrar a Image selecionada
     var uiImage: UIImage? {
         guard let selectedImageData else { return nil }
         return UIImage(data: selectedImageData)
     }
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $pickerItem) {
                    if let uiImage {
                        Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture",
                                               systemImage: "photo.badge.plus",
                                               description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .frame(height: 200)
                .onChange(of: pickerItem, loadImage)
                
                // Se o usuario selecionou uma imagem, mostrar o textfield
                if selectedImageData != nil {
                    TextField("Contact name", text: $name)
                        .padding()
                        .background(Color.brown.tertiary)
                        .cornerRadius(50)
                        .padding([.top], 25)
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button ("Cancel"){
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button ("Save"){
                        saveNewContact()
                    }
                    .disabled(disableButton)
                }
            }
        }
    }
    
    func loadImage() {
        Task {
            if let imageData = try await pickerItem?.loadTransferable(type: Data.self) {
                selectedImageData = imageData
            }
        }
    }
    
    func saveNewContact(){
        guard let selectedImageData = selectedImageData else { return }
        
        let newContact = Contact(name: name, image: selectedImageData)
    
        dataManager.addContact(newContact)
        
        dismiss()
    }
}

#Preview {
    AddContactView()
        .environment(DataManager.shared)
}

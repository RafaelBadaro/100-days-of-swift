//
//  ContentView.swift
//  day77-challenge-photo-contacts
//
//  Created by Rafael Badaró on 14/07/25.
//

/**
 Have you ever been to a conference or a meetup, chatted to someone new, then realized seconds after you walk away that you’ve already forgotten their name? You’re not alone, and the app you’re building today will help solve that problem and others like it.

 Your goal is to build an app that asks users to import a picture from their photo library, then attach a name to whatever they imported. The full collection of pictures they name should be shown in a List, and tapping an item in the list should show a detail screen with a larger version of the picture.

 Breaking it down, you should:

 - Use PhotosPicker to let users import a photo from their photo library.
 - Detect when a new photo is imported, and immediately ask the user to name the photo.
 - Save that name and photo somewhere safe.
 - Show all names and photos in a list, sorted by name.
 - Create a detail screen that shows a picture full size.
 - Decide on a way to save all this data.
 
 Remember to import the user's photo as Data, so you can write it out easily.
 */
import SwiftUI

struct ContentView: View {
    @State private var contacts: [Contact] = []
    @State private var showingAddContactSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if contacts.isEmpty {
                    emptyContent
                } else {
                    bodyContent
                }
            }
            .navigationTitle("Contacts")
            .sheet(isPresented: $showingAddContactSheet) {
                AddContactView(contacts: $contacts)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showingAddContactSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                self.fetchContacts()
            }
        }
    }
    
    func fetchContacts() {
        contacts = DataManager.load()
    }
}

extension ContentView {
    private var emptyContent: some View {
        Text("No contacts yet!")
            .font(.headline)
            .foregroundColor(.secondary)
    }
    private var bodyContent: some View {
        List {
            ForEach(contacts.sorted()) { contact in
                NavigationLink(value: contact) {
                    HStack {
                        if let uiImage = contact.uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        }
                        
                        Text(contact.name)
                    }
                }
            }
        }
         .navigationDestination(for: Contact.self) { contact in
             EditContactView(contact: contact, contacts: $contacts)
         }
    }
}

#Preview {
    ContentView()
}

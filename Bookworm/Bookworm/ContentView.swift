//
//  ContentView.swift
//  Bookworm
//
//  Created by Rafael Badaró on 01/05/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
//    @Query(sort: \Book.title) var books: [Book]
    @Query(sort: [
            SortDescriptor(\Book.title),
            SortDescriptor(\Book.author),
        ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .listRowBackground(book.rating <= 1 ?
                                       Color.red.opacity(0.6) : Color(UIColor.systemBackground))
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
    
}

#Preview {
    ContentView()
}


/*
 
 
 Exemplo de como adicionar o SwiftData bem simples no apps:
 
 import SwiftData

 struct ContentView: View {
     @Environment(\.modelContext) var modelContext
     @Query var students: [Student]
     
     var body: some View {
         NavigationStack {
             List (students) {
                 Text($0.name)
             }
             .navigationTitle("Classroom")
             .toolbar {
                 Button("Add") {
                     let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                     let lastNames = ["Granger", "Lovegood", "Potter", "Luna", "Weasley"]
                     
                     let chosenFirstName = firstNames.randomElement()!
                     let chosenLastName = lastNames.randomElement()!
                     
                     let newStudent = Student(id: UUID(),
                                              name: "\(chosenFirstName) \(chosenLastName)")
                     
                     modelContext.insert(newStudent)
                 }
             }
         }
     }
     
 }
 
 
 import SwiftData

 @main
 struct BookwormApp: App {
     var body: some Scene {
         WindowGroup {
             ContentView()
         }
         .modelContainer(for: Student.self)
     }
 }

 
 
 import SwiftData

 @Model
 class Student {
     var id: UUID
     var name: String
     
     init(id: UUID, name: String) {
         self.id = id
         self.name = name
     }
 }
 
 
 --------------
 
 struct ContentView: View {
    
     @AppStorage("notes") private var notes = ""
     
     var body: some View {
         NavigationStack {
             TextField("Enter your text", text: $notes, axis: .vertical)
                 .textFieldStyle(.roundedBorder)
                 .navigationTitle("Notes")
                 .padding()
         }
     }
 }

 
 struct ContentView: View {
    
     @AppStorage("notes") private var notes = ""
     
     var body: some View {
         NavigationStack {
             TextEditor(""text: $notes)
                 .navigationTitle("Notes")
                 .padding()
         }
         
     }
 }
 
 --------------
 
 struct PushButton: View {
     let title: String
     // A variavel de @State aqui cria outra "source of truth" entao a ContentView, perde o "poder" sobre essa view
 //    @State var isOn: Bool
     @Binding var isOn: Bool
     
     var onColors = [Color.red, Color.yellow]
     var offColors = [Color(white: 0.6), Color(white: 0.4)]
     
     var body: some View {
         Button(title) {
             isOn.toggle()
         }
         .padding()
         .background(
             LinearGradient(colors: isOn ? onColors : offColors,
                            startPoint: .top,
                            endPoint: .bottom))
         .foregroundStyle(.white)
         .clipShape(.capsule)
         .shadow(radius: isOn ? 0 : 5)
     }
 }

 struct ContentView: View {
     @State private var rememberMe = false
     
     var body: some View {
         VStack {
             PushButton(title: "Rembember me", isOn: $rememberMe)
             Text(rememberMe ? "On" : "Off")
         }
     }
 }
 
 */

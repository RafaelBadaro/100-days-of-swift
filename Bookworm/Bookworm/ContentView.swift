//
//  ContentView.swift
//  Bookworm
//
//  Created by Rafael Badaró on 01/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Bookwormapp")
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

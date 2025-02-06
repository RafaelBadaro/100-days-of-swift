//
//  ContentView.swift
//  iExpense
//
//  Created by Rafael Badaró on 05/02/25.
//


import SwiftUI


struct ContentView: View {


    var body: some View {


    }
    
}

#Preview {
    ContentView()
}

/*
 
 struct User : Codable {
     let firstName: String
     let lastName: String
     
 }

 struct ContentView: View {
     @State private var user = User(firstName: "Taylor", lastName: "Swift")

     var body: some View {
         Button("Save User") {
             let encoder = JSONEncoder()
             
             if let data = try? encoder.encode(user) {
                 UserDefaults.standard.set(data, forKey: "UserData")
             }
             
         }

     }
     
 }

 
 
 
 */

// -------------------------

/*
 
 struct ContentView: View {
     
     @AppStorage("tapCount") private var tapCount = 0

     var body: some View {

         Button("Tap Count: \(tapCount)"){
             tapCount += 1
         }
         
     }
     
 }
 
 struct ContentView: View {
     
     @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

     var body: some View {

         Button("Tap Count: \(tapCount)"){
             tapCount += 1
             
             UserDefaults.standard.set(tapCount, forKey: "Tap")
         }
         
     }
     
 }
 
 
 */

// ---------------------------
/*
 
 struct ContentView: View {
     
     @State private var numbers = [Int]()
     @State private var currentNumber = 1
     
     var body: some View {
         NavigationStack {
             VStack {
                 List {
                     // O onDelete() so funciona no ForEach!!!
                     ForEach(numbers, id: \.self) {
                         Text("Row \($0)")
                     }
                     .onDelete(perform: removeRows)
                 }
                 
                 Button("Add Number") {
                     numbers.append(currentNumber)
                     currentNumber += 1
                 }
             }
             .toolbar {
                 EditButton()
             }
         }
         
     }
     
     func removeRows(at offsets: IndexSet) {
         numbers.remove(atOffsets: offsets)
     }
     
 }
 */

// -------------
/*
 import SwiftUI
 
 struct SecondView: View {
 @Environment(\.dismiss) var dismiss
 let name: String
 
 var body: some View {
 Button("Dismiss") {
 dismiss()
 }
 }
 }
 
 struct ContentView: View {
 
 @State private var showingSheet = false
 
 var body: some View {
 Button("Show sheet") {
 showingSheet.toggle()
 }
 .sheet(isPresented: $showingSheet) {
 SecondView(name: "new name")
 }
 }
 }
 */

//----------------
/*
 
 import Observation
 import SwiftUI
 
 @Observable
 class User {
 var firstName = "Bilbo"
 var lastName = "Baggins"
 }
 
 struct ContentView: View {
 
 @State private var user = User()
 
 var body: some View {
 VStack {
 Text("Your name is \(user.firstName) \(user.lastName)")
 
 TextField("Fn", text: $user.firstName)
 TextField("Ln", text: $user.lastName)
 }
 .padding()
 }
 }
 */

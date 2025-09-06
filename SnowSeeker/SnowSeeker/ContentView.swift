//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rafael Badaró on 06/09/25.
//

import SwiftUI


struct ContentView: View {

    
    var body: some View {
   
    }
}

#Preview {
    ContentView()
}

/**
 
 Day 96 - aula 3
 
 ------
 Day 96 - aula 2
 
 struct User: Identifiable {
     var id = "Test"
 }
 
 struct ContentView: View {
     @State private var selectedUser: User? = nil
     
     var body: some View {
         Button("Tap me") {
             selectedUser = User()
         }
         .sheet(item: $selectedUser) { unwrappedUser in
             Text(unwrappedUser.id)
         }
     }
 }
 
 struct ContentView: View {
     @State private var selectedUser: User? = nil
     @State private var isShowingAlert = false
     
     var body: some View {
         Button("Tap me") {
             selectedUser = User()
             isShowingAlert = true
         }
         .alert("Hello", isPresented: $isShowingAlert, presenting: selectedUser) { unwrappedUser in
             Text(unwrappedUser.id)
         }
     }
 }
 
 
 
 */

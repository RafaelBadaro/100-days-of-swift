//
//  ContentView.swift
//  BucketList
//
//  Created by Rafael Badaró on 11/06/25.
//

import SwiftUI

extension FileManager {
    
    func read (_ fileName: String) -> String {
        let url = URL.documentsDirectory.appendingPathComponent(fileName)
        
        guard let data = try? String(contentsOf: url, encoding: .utf8) else {
            fatalError()
        }
    
        return data
    }
    
    func write(_ fileName: String,_ dataToWrite: Data){
        let url = URL.documentsDirectory.appendingPathComponent(fileName)
        try? dataToWrite.write(to: url, options: [.atomic, .completeFileProtection])
    }
}

struct ContentView: View {
  
    
    var body: some View {
        Button("Read and Write") {
            let data = Data("Test Message".utf8)
            FileManager.default.write("message.txt", data)
            let input: String = FileManager.default.read("message.txt")
            print(input)
        }
    }
    
    
}

#Preview {
    ContentView()
}

/***
 
 Aula 1:
 
 struct User: Comparable, Identifiable {
     let id = UUID()
     var firstname: String
     var lastName: String
     
     // Sim a func chama "<"
     static func < (lhs: User, rhs: User) -> Bool {
         lhs.lastName < rhs.lastName
     }
 }

 struct ContentView: View {
     
     let users = [
         User(firstname: "Arnold", lastName: "Rimmer"),
         User(firstname: "Kristine", lastName: "Kochanski"),
         User(firstname: "David", lastName: "Lister"),
     ].sorted()
     
     var body: some View {
         List(users) { user in
             Text("\(user.lastName), \(user.firstname)")
         }
     }
 }
 
 
 --------
 
 Aula 2:
 
 
 
 --------
 
 Aula 3:
 
 */

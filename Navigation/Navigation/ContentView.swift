//
//  ContentView.swift
//  Navigation
//
//  Created by Rafael Badaró on 12/03/25.
//

import SwiftUI


struct ContentView: View {
    
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack {
            Text("A")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}



/*
 
 
 
 @State private var title = "SwiftUI"
 
 var body: some View {
     NavigationStack {
         Text("A")
             .navigationTitle($title)
             .navigationBarTitleDisplayMode(.inline)
     }
 }
 
 ----------------
 
 NavigationStack{
     Text("A")
         .toolbar {
             ToolbarItemGroup(placement: .topBarLeading) {
                 Button("Tap Me") {
                     // button action code
                 }
                 Button("Tap Me") {
                     // button action code
                 }
             }
         }
         .navigationBarBackButtonHidden()
 }
 
 ----------------
 
 NavigationStack{
     List(0..<100) { i in
         Text("Row \(i)")
     }
     .navigationTitle("Title goes here")
     .navigationBarTitleDisplayMode(.inline)
     .toolbarBackground(.blue)
      //.toolbarBackground(.blue, for: .navigationBar) se quiser só mudar a navigationBar
     .toolbarColorScheme(.dark)
     .toolbar(.hidden, for: .navigationBar) // esconder a navbar
 }
 
 ----------------
 
 @Observable
 class PathStore {
     //var path: [Int] {
     var path: NavigationPath {
         didSet {
             save()
         }
     }
     
     private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
     
     init() {
         if let data = try? Data(contentsOf: savePath) {
             //if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
             //    path = decoded
             if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                 path = NavigationPath(decoded)
                 return
             }
         }
         
         //path = []
         path = NavigationPath()
     }
     
     func save() {
         guard let representation = path.codable else { return }
         
         do {
             // Com int
             //let data = try JSONEncoder().encode(path)
             let data = try JSONEncoder().encode(representation)
             try data.write(to: savePath)
         } catch {
             print("Failed to save navigation data")
         }
     }
     
 }

 struct DetailView: View {
     var number: Int
     var body: some View {
         NavigationLink("Go to random number", value: Int.random(in: 1...1000))
             .navigationTitle("Number: \(number)")
     }
 }

 struct ContentView: View {
     @State private var pathStore = PathStore()
     
     var body: some View {
         NavigationStack (path: $pathStore.path) {
             DetailView(number: 0)
                 .navigationDestination(for: Int.self) { i in
                     DetailView(number: i)
                 }
         }
     }
 }
 
 
 
 ----------------
 
 struct DetailView: View {
     var number: Int
 //    @Binding var path: [Int]
     @Binding var path: NavigationPath
     
     var body: some View {
         NavigationLink("Go to random number", value: Int.random(in: 1...1000))
             .navigationTitle("Number: \(number)")
             .toolbar {
                 Button("Home") {
                     path = NavigationPath()
                 }
             }
     }
 }

 struct ContentView: View {
   //  @State private var path = [Int]()
     @State private var path = NavigationPath()
     
     var body: some View {
         NavigationStack (path: $path) {
             DetailView(number: 0, path: $path)
                 .navigationDestination(for: Int.self) { i in
                     DetailView(number: i, path: $path)
                 }
         }
     }
 }
 
 
 
 ----------------
 
 @State private var path = NavigationPath()
 
 var body: some View {
 NavigationStack (path: $path) {
 List {
 ForEach(0..<5) { i in
 NavigationLink("Select number \(i)", value: i)
 }
 ForEach(0..<5) { i in
 NavigationLink("Select string \(i)", value: String(i))
 }
 }
 .toolbar {
 Button("Push 556") {
 path.append(556)
 }
 Button("Push Hello") {
 path.append("Hello")
 }
 }
 .navigationDestination(for: Int.self){ selection in
 Text("You selected the number \(selection)")
 }
 .navigationDestination(for: String.self){ selection in
 Text("You selected the string \(selection)")
 }
 
 }
 }
 
 --------------
 
 @State private var path = [Int]()
 
 var body: some View {
 NavigationStack (path: $path) {
 VStack {
 Button("Show 32") {
 path = [32]
 }
 
 Button("Show 64") {
 path.append(64)
 }
 
 Button("Show 32 then 64") {
 path = [32,64]
 }
 }
 .navigationDestination(for: Int.self){ selection in
 Text("You selected \(selection)")
 }
 }
 }
 
 -----------------
 
 //Com o navigationDestination, ela não cria
 NavigationStack {
 List(0..<100) { i in
 NavigationLink("Select \(i)", value: i)
 }
 .navigationDestination(for: Int.self) { selection in
 Text("You selected \(selection)")
 }
 }
 
 // Usando assim o SwiftUI cria a view de dentro, no caso Text, mesmo antes dela ser chamada
 NavigationStack {
 NavigationLink("Tap") {
 Text("Detail View")
 }
 }
 
 */

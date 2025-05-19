//
//  ContentView.swift
//  iExpense
//
//  Created by Rafael Badaró on 05/02/25.
//


import SwiftUI
import Observation

 
struct AmountStyleModifier: ViewModifier {
    var amount: Double
    
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .foregroundStyle(styleAmount(amount: amount))
    }
    
    private func styleAmount(amount: Double) -> Color {
        if amount <= 10 {
            return .blue
        }
        
        if amount <= 100 {
            return .yellow
        }
        
        return .red
    }
}

extension View {
    func amountStyle(_ amount: Double) -> some View {
        self.modifier(AmountStyleModifier(amount: amount))
    }
}

struct ContentView: View {
    @State private var showingAddExpense = false
    
    @State private var prefferedCurrency = Locale.current.currency?.identifier ?? "USD"
    let currencies = Locale.commonISOCurrencyCodes
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount, order: .reverse)
    ]
    
    let filterTypes = ["All", "Business", "Personal"]
    @State private var selectedExpenseType = "All"
        
    var body: some View {
        NavigationStack {
            ExpensesView(prefferedCurrency: prefferedCurrency,
                         expenseType: selectedExpenseType,
                         sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                
                Picker("Expense type", selection: $selectedExpenseType) {
                    ForEach(filterTypes, id: \.self){
                        Text($0)
                    }
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort order", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.amount, order: .reverse)
                            ])
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                SortDescriptor(\ExpenseItem.name)
                            ])
                    }
                }

                Picker("Select Currency", selection: $prefferedCurrency) {
                       ForEach(currencies, id: \.self) { currency in
                           Text(currency)
                       }
                }
                
                NavigationLink(destination: AddView(prefferedCurrency: prefferedCurrency)) {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }        
    }
    
}

//#Preview {
//    ContentView()
//}

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

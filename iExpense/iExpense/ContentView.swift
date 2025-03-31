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

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    @State private var prefferedCurrency = Locale.current.currency?.identifier ?? "USD"
    let currencies = Locale.commonISOCurrencyCodes
    
    private var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal"}
    }
    
    private var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business"}
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(personalExpenses) { item in
                        HStack {
                            VStack (alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: prefferedCurrency))
                                .amountStyle(item.amount)
                        }
                    }
                    .onDelete(perform: removePersonalExpense)
                }
                
                Section("Business") {
                    ForEach(businessExpenses) { item in
                        HStack {
                            VStack (alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: prefferedCurrency))
                                .amountStyle(item.amount)
                        }
                    }
                    .onDelete(perform: removeBusinessExpense)
                }

            }
            .navigationTitle("iExpense")
            .toolbar {
                Picker("Select Currency", selection: $prefferedCurrency) {
                       ForEach(currencies, id: \.self) { currency in
                           Text(currency)
                       }
                   }
                
                NavigationLink(destination: AddView(expenses: expenses, prefferedCurrency: prefferedCurrency)) {
                    Label("Add Expense", systemImage: "plus")
                }
            }
//            .sheet(isPresented: $showingAddExpense) {
//                AddView(expenses: expenses,
//                        prefferedCurrency: prefferedCurrency)
//            }
        }
        
    }
    
    //MARK: takeaway: esse IndexSet retorna os indexes dos arrays filtrados, ele cria novos quando a gente usa o .filter
    // Ou seja, no expenses.items os elementos dos index 0 e 1 vão ser diferentes dos elementos 0 e 1 do
    // array de personalExpenses e/ou businessExpenses
    func removePersonalExpense(at offsets: IndexSet) {
        // look at each item we are trying to delete
        for offset in offsets {
            // look in the personalItems array and get that specific item we are trying to delete. Find it's corresponding match in the expenses.items array.
            if let index =  expenses.items.firstIndex(where: { $0.id == personalExpenses[offset].id }){
                // delete the item from the expenses.items array at the index you found its match
                expenses.items.remove(at: index)
            }
        }
    }
    
    func removeBusinessExpense(at offsets: IndexSet) {
        for offset in offsets {
            if let index =  expenses.items.firstIndex(where: { $0.id == businessExpenses[offset].id }){
                expenses.items.remove(at: index)
            }
        }
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

//
//  AddView.swift
//  iExpense
//
//  Created by Rafael Badaró on 12/02/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = "New Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    var prefferedCurrency: String
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                //TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount",
                          value: $amount,
                          format: .currency(code: prefferedCurrency))
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            //.navigationTitle("Add new expense")
            .toolbar {
                // Usando ToolbarItem da pra escolher onde as coisas vao ficar
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
            
                ToolbarItem (placement: .confirmationAction) {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
            }
//            .toolbar {
//                Button("Save") {
//                    let item = ExpenseItem(name: name,
//                                           type: type,
//                                           amount: amount)
//                    expenses.items.append(item)
//                    dismiss()
//                }
//            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses(), prefferedCurrency: "USD")
}

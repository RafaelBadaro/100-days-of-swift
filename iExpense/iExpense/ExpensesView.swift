//
//  ExpensesView.swift
//  iExpense
//
//  Created by Rafael Badaró on 19/05/25.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    let preferredCurrency: String
    
    init(prefferedCurrency: String, expenseType: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
        self.preferredCurrency = prefferedCurrency
        _expenses = Query(filter: #Predicate { expense in
            if expenseType != "All" {
                return expense.type == expenseType
            } else {
               return true
            }
        }, sort: sortOrder)
    }
    
    var body: some View {
        List {
            if expenses.isEmpty {
                Text("You havent added this type of expense yet.")
            } else {
                ForEach(expenses) { expense in
                    HStack {
                        VStack (alignment: .leading) {
                            Text(expense.name)
                                .font(.headline)
                            Text(expense.type)
                        }
                        
                        Spacer()
                        
                        Text(expense.amount, format: .currency(code: preferredCurrency))
                            .amountStyle(expense.amount)
                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(expense.name), \(expense.type) expense, amount \(expense.amount.formatted(.currency(code: preferredCurrency)))")

                }
                .onDelete(perform: deleteExpenses)
            }
        }
    }
    
    func deleteExpenses(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

//#Preview {
//    ExpensesView()
//}

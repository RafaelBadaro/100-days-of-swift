//
//  MyWeSplitView.swift
//  WeSplit
//
//  Created by Rafael Badaró on 14/10/24.
//

import SwiftUI

struct MyWeSplitView: View {
    // MARK: State properties
    @State private var checkAmountText: String = ""
    @State private var checkAmount: Double = 0.0
    @FocusState private var checkAmountIsFocused: Bool
    
    @State private var tipPercentageText: String = ""
    @State private var tipPercentage: Double = 0.0
    @FocusState private var tipPercentageIsFocused: Bool
    
    @State private var numberOfPeople = 0
    
    // MARK: Calculated propertiess
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let grandTotal = checkAmount + tipAmount
        return grandTotal
    }
    
    var tipAmount: Double {
        let tipSelection = Double(tipPercentage/100)
        let tipAmount = checkAmount * tipSelection
        return tipAmount
    }
    
    // MARK: View properties
    let cardBgColor = Color(.green.opacity(0.7))
    let bgColor = Color(.yellow.opacity(0.3))
    let cornerRadius: CGFloat = 15
    let borderColor = Color.black
    let borderWidth: CGFloat = 2
    
    // MARK: Symbol and fallback properties
    let currencySymbol = Locale.current.currency?.identifier ?? "USD"
    var currencyFallback: String {
        "\(currencySymbol) 0,00"
    }
    var percentageFallback: String  = "0%"
    
    // MARK: Formatter for currency mask
    // Formatter that converts numeric string to currency format
    func formatAsCurrency(_ value: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "\(currencySymbol) "
        formatter.maximumFractionDigits = 2
        
        let numericValue = Double(value) ?? 0.0
        let formattedAmount = numericValue / 100.0 // Convert centavos to reais
        return formatter.string(from: NSNumber(value: formattedAmount)) ?? currencyFallback
    }
    
    // TODO: melhoria, nao deixar passar os valores de duas casas, exemplo:
    // 10,00, se digitar mais um zero, vira 100,00, o "certo" seria ignorar isso e manter como 10,00
    func formatAsPercent(_ value: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let numericValue = Double(value) ?? 0.0
        let formattedAmount = numericValue / 10000.0
        return formatter.string(from: NSNumber(value: formattedAmount)) ?? percentageFallback
    }
    
    
    // Clean input to only allow digits
    func cleanInputCheckAmount(_ value: String) -> String {
        return value.filter("0123456789".contains)
    }
    
    // Clean input to only allow digits
    func cleanInputPercent(_ value: String) -> String {
        return value.filter("0123456789".contains)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack (alignment: .leading) {
                    Text("Check Amount")
                        .font(.headline)
                    TextField(currencyFallback,
                              text: $checkAmountText)
                    .keyboardType(.numberPad)
                    .focused($checkAmountIsFocused)
                    .font(.title)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            if checkAmountIsFocused {
                                Button("Done") {
                                    checkAmountIsFocused = false
                                }
                            }
                        }
                    }
                    .onChange(of: checkAmountText) { oldValue, newValue in
                        let cleanedValue = cleanInputCheckAmount(newValue)
                        if let cleanedValueDouble = Double(cleanedValue) {
                            checkAmountText = formatAsCurrency(cleanedValue)
                            checkAmount = cleanedValueDouble / 100.0
                        } else {
                            checkAmountText = ""
                            checkAmount = 0.0
                        }
                    }
                }
                .padding()
                .background(cardBgColor)
                .cardStyle(cornerRadius: cornerRadius,
                           borderColor: borderColor,
                           borderWidth: borderWidth)
                .padding(.bottom, 20)
                
                HStack {
                    VStack {
                        Text("Number of people")
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach (2..<21){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.white.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .padding()
                    .background(cardBgColor)
                    .cardStyle(cornerRadius: cornerRadius,
                               borderColor: borderColor,
                               borderWidth: borderWidth)
                    .padding(.trailing, 10)
                    
                    VStack {
                        Text("Tip percentage")
                        TextField(percentageFallback,
                                  text: $tipPercentageText)
                        .keyboardType(.decimalPad)
                        .focused($tipPercentageIsFocused)
                        .font(.title2)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                if tipPercentageIsFocused {
                                    Button("Done") {
                                        tipPercentageIsFocused = false
                                    }
                                }
                            }
                        }
                        .onChange(of: tipPercentageText) { oldValue, newValue in
                            // Removendo a porcentagem %
                            let oldValueCleaned = oldValue.replacingOccurrences(of: "%", with: "")
                            let newValueCleaned = newValue.replacingOccurrences(of: "%", with: "")
                            
                            let cleanedValue = cleanInputPercent(newValueCleaned)
                            
                            if oldValueCleaned != newValueCleaned {
                                if let cleanedValueDouble = Double(cleanedValue) {
                                    tipPercentageText = formatAsPercent(cleanedValue)
                                    tipPercentage = cleanedValueDouble / 100.0
                                }
                                else {
                                    tipPercentageText = ""
                                    checkAmount = 0.0
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .padding()
                    .background(cardBgColor)
                    .cardStyle(cornerRadius: cornerRadius,
                               borderColor: borderColor,
                               borderWidth: borderWidth)
                    .padding(.leading, 10)
                }
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding([.top, .bottom], 10)
                
                
                VStack(alignment: .leading) {
                    Text("Grand total")
                        .font(.headline)
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.title)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(cardBgColor)
                .cardStyle(cornerRadius: cornerRadius,
                           borderColor: borderColor,
                           borderWidth: borderWidth)
                .padding(.top, 20)
                .padding(.bottom, 10)
                
                
                VStack (alignment: .leading){
                    Text("Total per person")
                        .font(.headline)
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.title)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(cardBgColor)
                .cardStyle(cornerRadius: cornerRadius,
                           borderColor: borderColor,
                           borderWidth: borderWidth)
                .padding([.top, .bottom], 10)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding([.leading, .trailing], 20)
            .background(bgColor)
            .navigationTitle("WeSplit")
        }
    }
}

#Preview {
    MyWeSplitView()
}

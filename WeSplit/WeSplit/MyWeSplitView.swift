//
//  MyWeSplitView.swift
//  WeSplit
//
//  Created by Rafael Badaró on 14/10/24.
//

import SwiftUI

struct MyWeSplitView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    
    /*
     MARK: setting tipPercentage like 0.xxx because the picker is using .percent
     
     ChatGPT explanation which I think its valid:
     The .percent format in SwiftUI expects the value to be in its fractional form, meaning 1.0 represents 100%, and 0.1 represents 10%. This is why when you set tipPercentage = 10, it shows as 1,000% because it interprets that 10 as 1,000%.
     */
    @State private var tipPercentage: Double = 0.100
    @FocusState private var amountIsFocused: Bool
    @FocusState private var tipPercentageIsFocused: Bool
    
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
        let tipSelection = Double(tipPercentage)
        let tipAmount = checkAmount * tipSelection
        return tipAmount
    }
    
    // MARK: View properties
    let cardBgColor = Color(.green.opacity(0.7))
    let bgColor = Color(.yellow.opacity(0.3))
    let cornerRadius: CGFloat = 15
    let borderColor = Color.black
    let borderWidth: CGFloat = 2
    
    // TODO: entender o problema dos textfields
    // 1 - Eles nao se formatam quando eu aperto o "Done"
    // 2 - E eu tenho que fazer com que o usuario digite como se fosse uma mask
    // igual o banco inter faz
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack (alignment: .leading) {
                    Text("Check Amount")
                        .font(.headline)
                    TextField("Amount", 
                              value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .font(.title)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                if amountIsFocused {
                                    Button("Done") {
                                        amountIsFocused = false
                                    }
                                }
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
                    VStack{
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
                        TextField("Tip Percentage",
                                  value: $tipPercentage,
                                  format: .percent)
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

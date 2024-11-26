//
//  ContentView.swift
//  day19-challenge-unit-conversion
//
//  Created by Rafael Badaró on 07/11/24.
//

/*
 Your challenge
 
 You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.

 Which units you choose are down to you, but you could choose one of these:
 
 Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
 
 Length conversion: users choose meters, kilometers, feet, yards, or miles.
 
 Time conversion: users choose seconds, minutes, hours, or days.
 
 Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
 */

// MARK: The challange is to choose one set of Units (like temperature for example) and make the converter. I'm gonna challenge myself and make the app convert all of the metrics.
// update 25/11/2025 -> that was cap, did only for temperature

import SwiftUI


enum TemperatureUnit: String, CaseIterable, Identifiable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var id: String { self.rawValue }
    
    func toCelsius(_ value: Double) -> Double {
        switch self {
        case .celsius: return value
        case .fahrenheit: return (value - 32) * 5 / 9
        case .kelvin: return value - 273.15
        }
    }
    
    func fromCelsius(_ value: Double) -> Double {
        switch self {
        case .celsius: return value
        case .fahrenheit: return value * 9 / 5 + 32
        case .kelvin: return value + 273.15
        }
    }

}

struct ContentView: View {
    @State private var selectedInputUnit: TemperatureUnit = .celsius
    @State private var inputUnit: Double = 0
    
    @State private var selectedOutputUnit: TemperatureUnit = .fahrenheit
    
    var outputUnit: Double {
        let celsiusValue = selectedInputUnit.toCelsius(inputUnit)
        return selectedOutputUnit.fromCelsius(celsiusValue)
    }
    
    
    var body: some View {
        VStack {
            VStack{
                Text("What do you want to convert?")
                    .font(.headline)
            }
           
            
            // MARK: InputUnit Section
            VStack {
                Picker("Unit", selection: $selectedInputUnit) {
                    ForEach(TemperatureUnit.allCases) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TextField("Input",
                          value: $inputUnit,
                          format: .number)
                .textFieldStyle(.roundedBorder)
                .padding()
                
            }.background(.brown)
            
            // MARK: OutputUnit Section
            VStack {
                Picker("Unit", selection: $selectedOutputUnit) {
                    ForEach(TemperatureUnit.allCases) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Text("Result: \(outputUnit, specifier: "%.2f")º \(selectedOutputUnit.rawValue)")
                .textFieldStyle(.roundedBorder)
                .padding()
                
            }.background(.yellow)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

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

// MARK: The challange is to choose one set of Units (like temperature for example) and make the converter. I'm gonna challenge myself and make the app convert all of the metrics

import SwiftUI


enum TemperatureUnit: String, CaseIterable, Identifiable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var id: String { self.rawValue }
}

struct ContentView: View {
    @State private var selectedInputUnit: TemperatureUnit = .celsius
    
    var inputUnit: Double = 0
    
    @State private var selectedOutputUnit: TemperatureUnit = .fahrenheit
    var outputUnit: Double = 0
    
    
    var body: some View {
        VStack {
            VStack{
                Text("What do you want to convert?")
                    .font(.headline)
                //Picker()
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
                
                //TextField()
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
                
                //Text()
            }.background(.yellow)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

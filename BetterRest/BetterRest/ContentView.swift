//
//  ContentView.swift
//  BetterRest
//
//  Created by Rafael Badaró on 09/01/25.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmout = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section (header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .headerProminence(.increased)
                .listRowBackground(Color.clear)
                
                Section (header: Text("Desired amount of sleep")) {
                    Stepper("\(sleepAmout.formatted()) hours",
                            value: $sleepAmout,
                            in: 4...12,
                            step: 0.25)
                }
                .headerProminence(.increased)
                .listRowBackground(Color.clear)


                Section (header: Text("Daily coffee intake")) {
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach (0..<21){
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                    .pickerStyle(.automatic)
                    
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)",
//                            value: $coffeeAmount,
//                            in: 1...20)
                    //Outra maneira
                    //Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                    //value: $coffeeAmount,
                    //in: 1...20)
                }
                .headerProminence(.increased)
                .listRowBackground(Color.clear)
                
                
                Text("Your ideal bedtime is: \(calculateBedtime())")
                    .font(.system(size: 25))
                    .bold()
                    .listRowBackground(Color.clear)
                
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") {}
//            } message: {
//                Text(alertMessage)
//            }
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
         
            
            let components = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60 // getting seconds
            let minute = (components.minute ?? 0) * 60 // getting seconds
            
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmout,
                coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep // in seconds
            let formattedSleepTime = sleepTime.formatted(date: .omitted, time: .shortened)
            return formattedSleepTime
            //alertTitle = "Your ideal bedtime is..."
            //alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }
        catch {
            //alertTitle = "Error"
            //alertMessage = "Sorry, there was a problema calculation your bedtime."
        }
        
        //showingAlert = true
        return "Error"
    }
    
}

#Preview {
    ContentView()
}

/*
 
 @State private var sleepAmout = 8.0
 
 @State private var wakeUp = Date.now
 
 var body: some View {
     Stepper("\(sleepAmout.formatted()) hours",
             value: $sleepAmout,
             in: 4...12,
             step: 0.25)
     
     DatePicker("Please enter a date",
                selection: $wakeUp,
                in: Date.now...)
         .labelsHidden()
     
//        Text(Date.now, format: .dateTime.day().month().year())
     Text(Date.now.formatted(date: .long, time: .shortened))
 }
 
//    func exampleDates() {
//        let tomorrow = Date.now.addingTimeInterval(86400)
//        let range = Date.now...tomorrow
//    }
 
 func exampleDates() {
//        let now = Date.now
//        let tomorrow = Date.now.addingTimeInterval(86400)
//        let range = now...tomorrow
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? .now

     let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
     let hour = components.hour ?? 0
     let minute = components.minute ?? 0
 }
 */

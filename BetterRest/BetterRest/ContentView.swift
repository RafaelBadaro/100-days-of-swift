//
//  ContentView.swift
//  BetterRest
//
//  Created by Rafael Badaró on 09/01/25.
//

import SwiftUI

struct ContentView: View {
    
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
    
}

#Preview {
    ContentView()
}

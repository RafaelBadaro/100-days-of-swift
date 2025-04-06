//
//  DetailActivityView.swift
//  habit-tracker
//
//  Created by Rafael Badaró on 06/04/25.
//

import SwiftUI

struct DetailActivityView: View {
    @Binding var activityItem: ActivityItem
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(activityItem.title)
                .font(.title)
                .bold()
            Text(activityItem.description)
                .font(.body)
            Text("Completions: \(activityItem.completionCount)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Button ("Increment") {
                activityItem.completionCount += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    DetailActivityView(activityItem: .constant(ActivityItem(
        title: "Teste",
        description: "a",
        completionCount: 0
    )))
}

//
//  DetailActivityView.swift
//  habit-tracker
//
//  Created by Rafael Badaró on 06/04/25.
//

import SwiftUI

// MARK: Sem usar binding
// Obs: o valor não atualiza na tela! Portanto coloquei pra dismiss na view
struct DetailActivityView: View {
    var activityItem: ActivityItem
    var activities: Activities
    
    @Environment(\.dismiss) var dismiss
    
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
                if let index = activities.items.firstIndex(of: activityItem) {
                    let newActivity = ActivityItem(
                        title: activityItem.title,
                        description: activityItem.description,
                        completionCount: activityItem.completionCount + 1)
                    
                    activities.items[index] = newActivity
                }
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    DetailActivityView(activityItem: ActivityItem(
        title: "Teste",
        description: "Description",
        completionCount: 0
    ), activities: Activities())
}

// MARK: Usando binding
//struct DetailActivityView: View {
//    @Binding var activityItem: ActivityItem
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text(activityItem.title)
//                .font(.title)
//                .bold()
//            Text(activityItem.description)
//                .font(.body)
//            Text("Completions: \(activityItem.completionCount)")
//                .font(.subheadline)
//                .foregroundStyle(.secondary)
//            
//            Button ("Increment") {
//                activityItem.completionCount += 1
//            }
//            .buttonStyle(.borderedProminent)
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    DetailActivityView(activityItem: .constant(ActivityItem(
//        title: "Teste",
//        description: "a",
//        completionCount: 0
//    )))
//}

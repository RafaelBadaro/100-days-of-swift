//
//  AddActivityView.swift
//  habit-tracker
//
//  Created by Rafael Badaró on 06/04/25.
//

import SwiftUI

struct AddActivityView : View {
    @Environment(\.dismiss) var dismiss
    var activities: Activities

    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Activity")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
                
                ToolbarItem (placement: .confirmationAction) {
                    Button ("Save") {
                        let activity = ActivityItem(title: title,
                                                    description: description,
                                                    completionCount: 0)
                        activities.items.append(activity)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}

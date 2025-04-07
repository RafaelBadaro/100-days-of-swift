//
//  ContentView.swift
//  habit-tracker
//
//  Created by Rafael Badaró on 04/04/25.
//

import SwiftUI
import Observation

struct ActivityItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount: Int
}

@Observable
class Activities {
    var items = [ActivityItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showAddActivityView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                // MARK: Sem usar binding
                ForEach(activities.items) { activity in
                    NavigationLink(destination: DetailActivityView(activityItem: activity, activities: activities)) {
                        Text(activity.title)
                            .font(.headline)
                            .foregroundStyle(.primary)
                    }
                }
                .onDelete(perform: deleteActivity)
                
                  // MARK: Usando binding
//                ForEach($activities.items) { $activity in
//                    NavigationLink(destination: DetailActivityView(activityItem: $activity)) {
//                        Text(activity.title)
//                            .font(.headline)
//                            .foregroundStyle(.primary)
//                    }
//                }
//                .onDelete(perform: deleteActivity)
            }
            .navigationTitle("Activities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddActivityView.toggle()
                    } label : {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddActivityView) {
                AddActivityView(activities: activities)
                    .presentationDetents([.medium])
            }
        }
    }
    
    private func deleteActivity(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
    
    
}

#Preview {
    ContentView()
}

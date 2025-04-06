//
//  ContentView.swift
//  habit-tracker
//
//  Created by Rafael Badaró on 04/04/25.
//

import SwiftUI
import Observation

// TODOS:
// Criar classe para segurar lista de activities pra salvar no user defaults com codable
// Criar visualizacao de add/edit (que vai receber ou nao uma activity, vai ter o dismiss e vai receber a lista de activities pra alterar ela)

struct ActivityItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount: Int
}

@Observable
class Activities {
    var items: [ActivityItem]
    
    init() {
        items = []
    }
}

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showAddActivityView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { activity in
                    HStack {
                        VStack (alignment: .leading) {
                            Text(activity.title)
                                .font(.headline)
                                .foregroundStyle(.primary)
                            Text(activity.description)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("Completions: \(activity.completionCount)")
                    }
                }
                .onDelete(perform: deleteActivity)
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

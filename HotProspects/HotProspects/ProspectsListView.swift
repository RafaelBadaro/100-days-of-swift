//
//  ProspectsListView.swift
//  HotProspects
//
//  Created by Rafael Badaró on 18/08/25.
//

import SwiftData
import SwiftUI

struct ProspectsListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    @Binding var selectedProspects: Set<Prospect>
    
    let filter: FilterType
    
    init(filter: FilterType,
         selectedProspects: Binding<Set<Prospect>>,
         sortOrder: [SortDescriptor<Prospect>]) {
        self.filter = filter
        self._selectedProspects = selectedProspects
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            _prospects = Query(filter: #Predicate { $0.isContacted == showContactedOnly },
                               sort: sortOrder)
        } else {
            _prospects = Query(sort: sortOrder)
        }

    }
    
    var body: some View {
        NavigationStack {
            List(prospects, selection: $selectedProspects) { prospect in
                NavigationLink(destination: ProspectDetailView(selectedProspects: $selectedProspects, prospect: prospect)) {
                    HStack {
                        VStack (alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        if self.filter == .none {
                            Image(systemName: prospect.isContacted ? "checkmark.message" : "message.badge")
                        }
                    }
                }
                .tag(prospect)
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                    }
                    
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                        
                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
            }
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            // MARK: For testing
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content,
                                                trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
}

#Preview {
    ProspectsListView(filter: .contacted,
                      selectedProspects: .constant([]),
                      sortOrder:[SortDescriptor(\Prospect.name)])
}

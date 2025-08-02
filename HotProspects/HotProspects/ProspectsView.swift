//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Rafael Badaró on 02/08/25.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted pepole"
        case .uncontacted:
            "Uncontacted pepole"
        }
    }
    
    var body: some View {
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.navigationTitle(title)
       
    }
}

#Preview {
    ProspectsView(filter: .none)
}

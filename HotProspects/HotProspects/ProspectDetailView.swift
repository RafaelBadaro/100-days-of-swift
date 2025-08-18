//
//  ProspectDetailView.swift
//  HotProspects
//
//  Created by Rafael Badaró on 17/08/25.
//

import SwiftUI

struct ProspectDetailView: View {
    /*
     Passando selectedProspects aqui pra solucionar o erro de usar List (selection:) + NavigationLink
     Ao clicar em um item da lista o item escolhido fica selecionado e o botão "Delete Selected" aparece
     A solução que pensei: ao entrar nessa tela de detalhes limpar a lista de selectedProspects no onAppear
    */
    @Binding var selectedProspects: Set<Prospect>
    
    @Bindable var prospect: Prospect
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Name", text: $prospect.name)
                TextField("Email Address", text: $prospect.emailAddress)
            }
            .navigationTitle("Edit Prospect")
        }.onAppear {
            selectedProspects.removeAll()
        }
 
    }
}

#Preview {
    ProspectDetailView(
        selectedProspects: .constant([]),
        prospect: Prospect(name: "test", emailAddress: "test", isContacted: false)
    )
}

//
//  SettingsView.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/10/2020.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contatti")) {
                    NavigationLink(destination: Link("Mail", destination: URL(string: "mailto:gabriele.dintino@icloud.com")!)) {
                        Link("Mail", destination: URL(string: "mailto:gabriele.dintino@icloud.com")!)
                            .buttonStyle(PlainButtonStyle())
                    }
                    NavigationLink(destination: Link("Instagram", destination: URL(string: "https://www.instagram.com/gabriele.dintino/")!)) {
                        Link("Instagram", destination: URL(string: "https://www.instagram.com/gabriele.dintino/")!)
                            .buttonStyle(PlainButtonStyle())
                    }
                    Text("Per ogni problema, suggerimento, segnalazione di bug/crash e per proporre altri canti contattami utilizzando i social qui sopra!")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Section(header: Text("Ringraziamenti")) {
                    NavigationLink(destination: Text("Prova")) {
                        Text("Ringraziamenti")
                    }
                }
                
                VStack {
                    Text("Per mia moglie, che ha ispirato questa App.")
                    HStack {
                        Text("Ti amo")
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            
            .navigationTitle("Impostazioni")
//            .listStyle(InsetGroupedListStyle())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

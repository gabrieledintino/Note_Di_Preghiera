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
            VStack {
                Text("Per mia moglie, che ha ispirato questa App.")
                HStack {
                    Text("Ti amo")
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Impostazioni")
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

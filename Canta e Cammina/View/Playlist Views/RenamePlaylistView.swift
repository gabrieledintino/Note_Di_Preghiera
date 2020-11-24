//
//  RenamePlaylistView.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/10/2020.
//

import SwiftUI

struct RenamePlaylistView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var playlists: Playlists
    var oldName: String
    @State var newName: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Scegli il nuovo nome della scaletta")) {
                    TextField("Scegli il nuovo nome", text: $newName)
                }
            }
            .navigationTitle("Rinomina scaletta")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla", action: dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salva", action: { renamePlaylist(); dismiss() })
                }
            }
        }
        .onAppear(perform: { self.newName = oldName })
    }
    
    func renamePlaylist() {
        playlists.renamePlaylist(playlistName: oldName, newName: newName)
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct RenamePlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        RenamePlaylistView(oldName: "Prova")
    }
}

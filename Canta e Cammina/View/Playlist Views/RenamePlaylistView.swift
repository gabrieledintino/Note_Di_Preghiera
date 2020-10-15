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
        VStack {
            HStack {
                Spacer()
                Button("Fatto", action: { renamePlaylist(); dismiss() })
            }
            Spacer()
            Text("Scegli il nuovo nome della scaletta")
                .font(.headline)
            TextField("Scegli il nuovo nome", text: $newName)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            Spacer()
        }
        .padding()
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

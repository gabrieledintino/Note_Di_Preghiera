//
//  EditPlaylistView.swift
//  Canta e Cammina
//
//  Created by Gabriele on 27/09/2020.
//

import SwiftUI

struct AddPlaylistView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var favorites: Favorites
    @EnvironmentObject var playlists: Playlists
    @State private var playlistName = ""
    @State private var songs = Song.allSongsOrdered
    @State private var searchText = ""
    @State private var playlistContent: [String] = []

    
    var body: some View {
        VStack {
            TextField("Inserisci il nome della scaletta", text: $playlistName)
            SearchBar(text: $searchText)

            List(songs, id: \.self) { song in
                    VStack(alignment: .leading) {
                        Text(song.title)
                            .font(.headline)
                    }.layoutPriority(1)
                    
                if self.favorites.contains(song) {
                    Spacer()
                    Image(systemName: "heart.fill")
                    .accessibility(label: Text("This is a favorite song"))
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    if playlistContent.contains(song.title) {
                        playlistContent.append(song.title)
                    } else {
                        playlistContent.removeElement(element: song.title)
                    }
                }, label: {
                    playlistContent.contains(song.title) ? Image(systemName: "minus.circle.fill") : Image(systemName: "plus.circle.fill")
                })
            }
        }
        .navigationTitle("\(playlistName)")
        .navigationBarItems(trailing: Button("Fatto", action: {
            playlists.createPlaylist(playlistName: playlistName, songs: playlistContent)
            self.presentationMode.wrappedValue.dismiss()
        }))
    }
}

struct EditPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaylistView()
    }
}

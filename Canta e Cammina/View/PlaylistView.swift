//
//  PlaylistView.swift
//  Canta e Cammina
//
//  Created by Gabriele on 27/09/2020.
//

import SwiftUI

struct PlaylistView: View {

    @Environment(\.editMode) var editMode
    @EnvironmentObject var playlists: Playlists
    @EnvironmentObject var favorites: Favorites
    @State private var searchText = ""
    private var songs: [Song] {
        let songNames = playlists.getPlaylistSongs(playlistName: playlistName)
        return Song.allSongs.filter({ songNames.contains($0.title)})
    }
    var playlistName: String
    @State private var newName = ""
    

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            if editMode!.wrappedValue.isEditing {
                TextField("Modifica il nome della playlist", text: $newName, onCommit: { changePlaylistName(newName: newName)})
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
            }

            
            List {
                ForEach(songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) }), id: \.self) { song in
                    NavigationLink(destination: SongView(song)) {
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
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            
        }
        .navigationTitle("\(playlistName)")
        .navigationBarItems(trailing: EditButton())
    }
    
    func deleteItems(at offsets: IndexSet) {
        playlists.removeFromPlaylist(atOffsets: offsets, playlistName: playlistName)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        playlists.moveSongs(from: source, to: destination, playlistName: playlistName)
    }
    
    func changePlaylistName(newName: String) {
        playlists.renamePlaylist(oldName: playlistName, newName: newName)
    }
    
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(playlistName: "Prova")
    }
}

// songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) })

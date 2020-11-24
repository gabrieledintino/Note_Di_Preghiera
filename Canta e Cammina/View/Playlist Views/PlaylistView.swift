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
        return playlists.getPlaylistSongs(playlistName: playlistName)
    }
    var playlistName: String
    @State private var newName = ""
    @State private var showAddView = false
    

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            
            List {                                              //TODO: refactor this view (also in MainSongListView
                ForEach(songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) }), id: \.self) { song in
                    NavigationLink(destination: SongView(song)) {
                        VStack(alignment: .leading) {
                            Text(song.title)
                                .font(.headline)
                        }.layoutPriority(1)
                        
                        FavoriteHeart(song: song)
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
        }
        .sheet(isPresented: $showAddView) {
            AddSongView(playlistName: playlistName)
                .environmentObject(favorites)
        }
        .navigationTitle("\(playlistName)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { self.showAddView.toggle() }, label: {
                    Image(systemName: "plus")
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        playlists.removeFromPlaylist(atOffsets: offsets, playlistName: playlistName)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        playlists.moveSongs(from: source, to: destination, playlistName: playlistName)
    }
    
    func changePlaylistName(newName: String) {
        playlists.renamePlaylist(playlistName: playlistName, newName: newName)
    }
    
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(playlistName: "Uno")
            .environmentObject(Favorites())
            .environmentObject(Playlists())
    }
}

// songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) })

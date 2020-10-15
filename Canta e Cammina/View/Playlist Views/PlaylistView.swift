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
            ZStack {
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
                            
                            FavoriteHeart(song: song)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
                
//                if showAddView {
//                    AddSongView(playlistName: playlistName)
//                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                }
            }
            
        }
        .sheet(isPresented: $showAddView) {
            AddSongView(playlistName: playlistName)
                .environmentObject(favorites)
        }
        .navigationTitle("\(playlistName)")
        .navigationBarItems(trailing: HStack(spacing: 10) {
            Button(action: { withAnimation {
                self.showAddView.toggle()
            } }, label: {
                Image(systemName: "plus")
            })
            .disabled(showAddView)
            
            EditButton()
                .disabled(showAddView)
        })
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
        PlaylistView(playlistName: "Prova")
    }
}

// songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) })

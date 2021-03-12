//
//  PlaylistView.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/10/2020.
//

import SwiftUI

struct PlaylistsView: View {
    @EnvironmentObject var playlists: Playlists
    @State private var showRenamePlaylist: Playlist? = nil
    @State private var showAddPlaylist = false
    @State private var showDeletePlaylist: Playlist? = nil
    @State private var searchText = ""

    let songs = Song.allSongsOrdered
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 50, maximum: 400), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 50, maximum: 400), spacing: 0, alignment: .center),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, textHint: "Cerca una scaletta...")
                    .padding(.vertical, 5)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                        ForEach(playlistsFilter(), id: \.id) { playlist in
                            NavigationLink(destination: PlaylistView(playlistName: playlist.name)) {
                                GroupBox(
                                    label: Label("", systemImage: "folder")
                                            .foregroundColor(.red)
                                            .font(.callout)
                                            .padding(.bottom, 1)
                                ) {
                                    Text(playlist.name)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                } .groupBoxStyle(CardGroupBoxStyle())
                            }
                            .buttonStyle(PlainButtonStyle())                // this is needed to allow tapping on the "plus" sign
                            .contextMenu(menuItems: {
                                Button(action: {
                                    self.showRenamePlaylist = playlist
                                        }) {
                                    Text("Rinomina")
                                    Image(systemName: "pencil")
                                        }

                                Button(action: {
                                    self.showDeletePlaylist = playlist
                                        }) {
                                    Text("Elimina")
                                    Image(systemName: "trash")
                                        }
                            })
                            .actionSheet(item: $showDeletePlaylist) { playlist in
                                ActionSheet(title: Text("Sei sicuro di voler eliminare la scaletta \"\(playlist.name)\"?"), message: Text("Conferma"), buttons: [
                                    .destructive(Text("Elimina"), action: { self.deletePlaylist(playlistName: playlist.name) }),
                                    .cancel()
                                ])
                            }
                        }

                    }.animation(.default)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {                                            //MARK: Add playlist
                            withAnimation(.default) {
                                self.showAddPlaylist = true
                            }
                        } label: {
                            HStack {
                                Text("Aggiungi scaletta")
                                Image(systemName: "plus")
                            }
                    }
                }
            }
            .navigationTitle("Scalette")
            .sheet(isPresented: $showAddPlaylist) {
                AddPlaylistView().environmentObject(playlists)
            }
            .background(EmptyView()
                            .sheet(item: $showRenamePlaylist) { playlist in
                                RenamePlaylistView(oldName: playlist.name)
                            }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    fileprivate func playlistsFilter() -> [Playlist] {
        return playlists.getPlaylists().filter( { searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())})
    }
    
    func deletePlaylist(playlistName: String) {
        self.playlists.deletePlaylist(playlistName: playlistName)
    }
}

struct PlaylistsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsView()
    }
}

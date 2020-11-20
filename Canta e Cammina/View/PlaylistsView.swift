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

    let songs = Song.allSongsOrdered
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 50, maximum: 400), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 50, maximum: 400), spacing: 0, alignment: .center),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                        ForEach(playlists.getPlaylists(), id: \.id) { playlist in
                            NavigationLink(destination: PlaylistView(playlistName: playlist.getName())) {
//                                TileView(name: playlist.getName())
//                                    .frame(height: 60, alignment: .center)
                                GroupBox(
                                    label: Label("", systemImage: "folder")
                                        .foregroundColor(.red)
                                        .font(.callout)
                                        .padding(.bottom, 1)
                                ) {
                                    Text(playlist.getName())
                                        .font(.title3)
                                        .fontWeight(.bold)
                                } .groupBoxStyle(CardGroupBoxStyle())
                            }.buttonStyle(PlainButtonStyle())
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
                        }

                    }.animation(.default)
                }
                .padding()
            }
            .navigationBarItems(trailing: Button(action: {
                self.showAddPlaylist = true
            }, label: {
                HStack {
                    Text("Aggiungi scaletta")
                    Image(systemName: "plus")
                }
            }))
            .navigationTitle("Scalette")
            .sheet(isPresented: $showAddPlaylist) {
                AddPlaylistView().environmentObject(playlists)
            }
            .actionSheet(item: $showDeletePlaylist) { playlist in
                ActionSheet(title: Text("Sei sicuro di voler eliminare la scaletta \"\(playlist.getName())\"?"), message: Text("Conferma"), buttons: [
                    .destructive(Text("Elimina"), action: { self.deletePlaylist(playlistName: playlist.getName()) }),
                    .cancel()
                ])
            }
            
            .background(EmptyView()
                            .sheet(item: $showRenamePlaylist) { playlist in
                                RenamePlaylistView(oldName: playlist.getName())
                            }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
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

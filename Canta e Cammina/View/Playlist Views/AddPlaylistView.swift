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
    @State private var playlistContent: [Song] = []

    
    var body: some View {
        NavigationView {
            VStack {
                Text("Inserisci un nome per la tua nuova scaletta")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                TextField("Inserisci il nome della scaletta", text: $playlistName)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                
                Divider()
                
                SearchBar(text: $searchText, textHint: "Cerca una canzone...")
                    .padding(.top, 10)

                List(songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) }), id: \.self) { song in
                    VStack(alignment: .leading) {
                        Text(song.title)
                            .font(.headline)
                    }.layoutPriority(1)
                    
                    Spacer()

                    FavoriteHeart(song: song)
                    
                    if let index = playlistContent.firstIndex(of: song) {
                        Text("\(index + 1)")
                            .foregroundColor(Color(.systemGray))
                    }
                    
                    Button(action: {
                            if playlistContent.contains(song) {
                                    playlistContent.removeElement(element: song)
                            } else {
                                    playlistContent.append(song)
                            }
                    }, label: {
                        Image(systemName: playlistContent.contains(song) ? "minus.circle.fill" : "plus.circle.fill")
                            .animation(.default)
                            .foregroundColor(playlistContent.contains(song) ? Color.red : Color.green)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationTitle("\(playlistName)")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla", action: dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fatto", action: addAndDismiss)
                        .disabled(playlistName.isEmpty)
                }
            }
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    func addAndDismiss() {
        playlists.createPlaylist(playlistName: playlistName, songs: playlistContent)
        dismiss()
    }
}

struct AddPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaylistView()
            .environmentObject(Favorites())
            .environmentObject(Playlists())
    }
}

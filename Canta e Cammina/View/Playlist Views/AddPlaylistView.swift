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
        VStack {
            TextField("Inserisci il nome della scaletta", text: $playlistName)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            
            Divider()
            
            SearchBar(text: $searchText)
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
                        .foregroundColor(.blue)
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
            Button(action: {
                playlists.createPlaylist(playlistName: playlistName, songs: playlistContent)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Text("Fatto")
                        .padding(.horizontal)
                    Image(systemName: "checkmark")
                }
                .padding()
            })
            .foregroundColor(.white)
            .background(playlistName == "" ? Color.gray : Color.blue)
            .cornerRadius(8)
            .disabled(playlistName == "")
        }
        .padding()
        .navigationTitle("\(playlistName)")
    }
}

struct AddPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaylistView()
    }
}

//
//  SongList.swift
//  Canta e Cammina
//
//  Created by Gabriele on 13/10/2020.
//

import SwiftUI

struct MainSongListView: View {
    @EnvironmentObject var favorites: Favorites
    @State private var searchText = ""
    @State private var filterSongs = false
    var songs: [Song] {
        let startSongs = Song.allSongsOrdered
        if filterSongs {
            return startSongs.filter { self.favorites.contains($0) }
        } else {
            return startSongs
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, textHint: "Cerca una canzone...")
                    .padding(.vertical, 5)

                List(songFilter(), id: \.self) { song in
                    NavigationLink(destination: SongView(song)) {                                   //TODO: refactor this view (also in MainSongListView
                        VStack(alignment: .leading) {
                            Text(song.title)
                                .font(.headline)
                        }.layoutPriority(1)
                        
                       FavoriteHeart(song: song)
                    }
                }
            }
            .navigationTitle("Canta e Cammina 2.0")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filtra preferiti", action: { withAnimation(.default) {
                        self.filterSongs.toggle()
                    } })
                }
            }
        }
        .onAppear(perform: {
            print(Song.allSongsOrdered.count)
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    fileprivate func songFilter() -> [Song] {
        return songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) })
    }
}

struct MainSongListView_Previews: PreviewProvider {
    static var previews: some View {
        MainSongListView()
            .environmentObject(Favorites())
            .environmentObject(SongSettings())
            .environmentObject(RecentlyPlayedSongs())
            .environmentObject(Playlists())
            .environmentObject(UserNotes())
    }
}

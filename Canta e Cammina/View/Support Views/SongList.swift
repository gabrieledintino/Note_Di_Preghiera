//
//  SongList.swift
//  Canta e Cammina
//
//  Created by Gabriele on 13/10/2020.
//

import SwiftUI

struct SongList: View {
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
                SearchBar(text: $searchText)
                    .padding()

                
                List(songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) }), id: \.self) { song in
                    NavigationLink(destination: SongView(song)) {
                        VStack(alignment: .leading) {
                            Text(song.title)
                                .font(.headline)
                        }.layoutPriority(1)
                        
                       FavoriteHeart(song: song)
                    }
                }
            }
            .navigationBarItems(trailing: Button("Filtra preferiti", action: { self.filterSongs.toggle() }))
            .navigationTitle("Canta e Cammina 2.0")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SongList_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}

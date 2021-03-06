//
//  ListView.swift
//  Canta e Cammina
//
//  Created by Gabriele on 16/09/2020.
//

import SwiftUI

struct ListView: View {
    
    var songs: [Song]
    @EnvironmentObject var favorites: Favorites
    @State private var searchText = ""
    var category: String
    
    var filteredSongs: [Song] {
        songs.filter({ $0.categories.contains(category) })
    }

    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, textHint: "Cerca una canzone...")
                .padding()
                
            
            List(filteredSongs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) }), id: \.self) { song in
                NavigationLink(destination: SongView(song)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(song.title)
                                .font(.headline)
                        }.layoutPriority(1)
                    }
                    
                    if self.favorites.contains(song) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite song"))
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationTitle(category)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(songs: [Song.example], category: "Alleluia")
    }
}

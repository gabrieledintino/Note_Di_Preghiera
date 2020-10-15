//
//  RecentlyPlayedView.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/10/2020.
//

import SwiftUI

struct RecentlyPlayedView: View {
    @EnvironmentObject var recentlyPlayed: RecentlyPlayedSongs
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                        ForEach(recentlyPlayed.getRecentlyPlayed(), id: \.self) { song in
                            NavigationLink(destination: SongView(song)) {
                                TileView(name: song.title, fontStyle: .title3)
                                    .frame(height: 60)
                            }
                        }
                }
                .padding()
            }
            .navigationTitle("Recenti")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RecentlyPlayedView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyPlayedView()
    }
}

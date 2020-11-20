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
//                                TileView(name: song.title, fontStyle: .title3)
//                                    .frame(height: 60)
                                GroupBox(
                                    label: Label("", systemImage: "music.note")
                                        .foregroundColor(.red)
                                        .font(.callout)
                                        .padding(.bottom, 1)
                                ) {
                                    Text("\(song.title)")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                } .groupBoxStyle(CardGroupBoxStyle())
                            }.buttonStyle(PlainButtonStyle())
                        }
                }
                .padding()
            }
            .navigationTitle("Recenti")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CardGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            VStack(alignment: .leading) {
                configuration.label
                configuration.content
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.width)
        .background(Color(.systemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

struct RecentlyPlayedView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyPlayedView()
    }
}

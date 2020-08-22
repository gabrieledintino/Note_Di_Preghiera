//
//  HomeView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

struct HomeView: View {
	let songs: [Song] = Bundle.main.decode("songs.json")
	@ObservedObject var favorites = Favorites()
	
    var body: some View {
		NavigationView {
			List(songs) { song in
				NavigationLink(destination: SongView(song: song)) {
					VStack(alignment: .leading) {
						Text(song.title)
							.font(.headline)
					}
					
					if self.favorites.contains(song) {
						Spacer()
						Image(systemName: "heart.fill")
						.accessibility(label: Text("This is a favorite song"))
							.foregroundColor(.red)
					}
				}
			}
			.navigationTitle("Canta e Cammina")
			
			WelcomeView()
		}
//		.navigationViewStyle(StackNavigationViewStyle())

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  HomeView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

struct HomeView: View {
    let songs: [Song] = Song.allSongsOrdered
//	@EnvironmentObject var favorites: Favorites
	@State private var searchText = ""
	
    var body: some View {
		NavigationView {
			VStack {
				SearchBar(text: $searchText)
					.padding()

				
				List(songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) }), id: \.self) { song in
					NavigationLink(destination: SongView(song: song)) {
						VStack(alignment: .leading) {
							Text(song.title)
								.font(.headline)
						}.layoutPriority(1)
						
//						if self.favorites.contains(song) {
//							Spacer()
//							Image(systemName: "heart.fill")
//							.accessibility(label: Text("This is a favorite song"))
//								.foregroundColor(.red)
//						}
					}
				}
//				.frame(maxHeight: 500)
				
				Spacer()
				Section {
					VStack(alignment: .leading) {
						Text("Categorie")
							.font(.title)
							.fontWeight(.bold)
						ScrollView(.horizontal, showsIndicators: true) {
							HStack {
                                ForEach(Song.allCategories, id: \.self) { category in
                                    NavigationLink(destination: ListView(songs: songs, category: category)) {
                                        TileView(name: category)
                                            .frame(width: 200, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
								}
							}
						}
						Text("Scaletta")
							.font(.title)
							.fontWeight(.bold)
						ScrollView(.horizontal, showsIndicators: true) {
							HStack {
								ForEach(0..<6) {_ in
									Rectangle()
										.foregroundColor(.red)
										.frame(width: 200, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
								}
							}
						}
					}
					.padding()
				}
			}

			.navigationTitle("Canta e Cammina 2.0")
			
			
			WelcomeView()
		}
		
		.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

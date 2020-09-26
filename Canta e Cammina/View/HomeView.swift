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
    @EnvironmentObject var recentlyPlayed: RecentlyPlayedSongs
	@State private var searchText = ""
    @State private var showRecentlyPlayed = false
    @State private var showCategories = false
    @State private var showPlaylists = false
    let rows: [GridItem] = [
        GridItem(.flexible(minimum: 20, maximum: 40), spacing: 5),
        GridItem(.flexible(minimum: 20, maximum: 40), spacing: 5),
    ]
	
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
				HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Recenti")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading)
                            Button(action: {
                                withAnimation {
                                    self.showRecentlyPlayed.toggle()
                                }
                            }) {
                                Image(systemName: "chevron.right.circle")
                                    .imageScale(.large)
                                    .rotationEffect(.degrees(showRecentlyPlayed ? 90 : 0))
                                    .scaleEffect(showRecentlyPlayed ? 1.2 : 1)
                                    .padding()
                            }
                        }
                        if showRecentlyPlayed {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 0) {
                                    ForEach(recentlyPlayed.getRecentlyPlayed(), id: \.self) { song in
                                            NavigationLink(destination: SongView(song)) {
                                                TileView(name: song.title)
                                            }
                                    }
                                }
                                .frame(maxHeight: 40)
                            }
                        }
                        
                        HStack {
                            Text("Categorie")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading)
                            Button(action: {
                                withAnimation {
                                    self.showCategories.toggle()
                                }
                            }) {
                                Image(systemName: "chevron.right.circle")
                                    .imageScale(.large)
                                    .rotationEffect(.degrees(showCategories ? 90 : 0))
                                    .scaleEffect(showCategories ? 1.2 : 1)
                                    .padding()
                            }
                        }
                        if showCategories {
                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 0) {
//                                    ForEach(Song.allCategories, id: \.self) { category in
//                                        NavigationLink(destination: ListView(songs: songs, category: category)) {
//                                            TileView(name: category)
//                                                .frame(width: 200, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                        }
//                                    }
//                                }
                                
                                LazyHGrid(rows: rows, alignment: .center, spacing: 0) {
                                    ForEach(Song.allCategories, id: \.self) { category in
                                        NavigationLink(destination: ListView(songs: songs, category: category)) {
                                            TileView(name: category)
                                                .frame(width: 150, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        }
                                    }
                                }.frame(minHeight: 10, maxHeight: 100)
                            }
                        }
                        
                        HStack {
                            Text("Scaletta")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.leading)
                            Button(action: {
                                withAnimation {
                                    self.showPlaylists.toggle()
                                }
                            }) {
                                Image(systemName: "chevron.right.circle")
                                    .imageScale(.large)
                                    .rotationEffect(.degrees(showPlaylists ? 90 : 0))
                                    .scaleEffect(showPlaylists ? 1.2 : 1)
                                    .padding()
                            }
                        }

                        if showPlaylists {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(0..<6) {_ in
                                        Rectangle()
                                            .foregroundColor(.red)
                                            .frame(width: 200, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            }
                        }
					}
                    Spacer()
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
            .environmentObject(Settings())
            .environmentObject(RecentlyPlayedSongs())
    }
}

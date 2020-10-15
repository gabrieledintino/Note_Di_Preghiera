//
//  HomeView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

enum FilterSongs {
    case all, favorites
}

enum SortOrder {
    case alphabetical, none
}

struct HomeView: View {
    @State private var filterSongs = false
    var songs: [Song] {
        let startSongs = Song.allSongsOrdered
//        switch filterSongs {
//            case .all:
//                return startSongs
//            case .favorites:
//                return startSongs.filter { self.favorites.contains($0) }
//        }
        if filterSongs {
            return startSongs.filter { self.favorites.contains($0) }
        } else {
            return startSongs
        }
//        return songs.filter { filterSongs ? self.favorites.contains($0) : true }
    }
	@EnvironmentObject var favorites: Favorites
    @EnvironmentObject var recentlyPlayed: RecentlyPlayedSongs
    @EnvironmentObject var playlists: Playlists
    
//    @State private var selectedTab = ["Home", "Recenti", "Categorie", "Scaletta", "Impostazioni"]
    @State private var selectedTab = "Home"
    
	@State private var searchText = ""
    @State private var showRecentlyPlayed = false
    @State private var showCategories = false
    @State private var showPlaylists = true
    @State private var showAddPlaylist = false
    @State private var showActionSheet = false
    let rows: [GridItem] = [
        GridItem(.flexible(minimum: 20, maximum: 40), spacing: 5),
        GridItem(.flexible(minimum: 20, maximum: 40), spacing: 5),
    ]
	
    var body: some View {
            TabView(selection: $selectedTab) {
//                VStack {
//                    SongList()
//
//                    Spacer()
//                    HStack {
//                        VStack(alignment: .leading, spacing: 5) {
//                            HStack {
//                                Text("Recenti")
//                                    .font(.title)
//                                    .fontWeight(.bold)
//                                    .padding(.leading)
//                                Button(action: {
//                                    withAnimation {
//                                        self.showRecentlyPlayed.toggle()
//                                    }
//                                }) {
//                                    Image(systemName: "chevron.right.circle")
//                                        .imageScale(.large)
//                                        .rotationEffect(.degrees(showRecentlyPlayed ? 90 : 0))
//                                        .scaleEffect(showRecentlyPlayed ? 1.2 : 1)
//                                        .padding()
//                                }
//                            }
//                            if showRecentlyPlayed {
//                                ScrollView(.horizontal, showsIndicators: false) {
//                                    HStack(spacing: 0) {
//                                        ForEach(recentlyPlayed.getRecentlyPlayed(), id: \.self) { song in
//                                                NavigationLink(destination: SongView(song)) {
//                                                    TileView(name: song.title)
//                                                }
//                                        }
//                                    }
//                                    .frame(maxHeight: 40)
//                                }
//                            }
//
//                            HStack {
//                                Text("Categorie")
//                                    .font(.title)
//                                    .fontWeight(.bold)
//                                    .padding(.leading)
//                                Button(action: {
//                                    withAnimation {
//                                        self.showCategories.toggle()
//                                    }
//                                }) {
//                                    Image(systemName: "chevron.right.circle")
//                                        .imageScale(.large)
//                                        .rotationEffect(.degrees(showCategories ? 90 : 0))
//                                        .scaleEffect(showCategories ? 1.2 : 1)
//                                        .padding()
//                                }
//                            }
//                            if showCategories {
//                                ScrollView(.horizontal, showsIndicators: false) {
//    //                                HStack(spacing: 0) {
//    //                                    ForEach(Song.allCategories, id: \.self) { category in
//    //                                        NavigationLink(destination: ListView(songs: songs, category: category)) {
//    //                                            TileView(name: category)
//    //                                                .frame(width: 200, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//    //                                        }
//    //                                    }
//    //                                }
//
//                                    LazyHGrid(rows: rows, alignment: .center, spacing: 0) {
//                                        ForEach(Song.allCategories, id: \.self) { category in
//                                            NavigationLink(destination: ListView(songs: songs, category: category)) {
//                                                TileView(name: category)
//                                                    .frame(width: 150, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                            }
//                                        }
//                                    }.frame(minHeight: 10, maxHeight: 100)
//                                }
//                            }
//
//                            HStack {
//                                Text("Scaletta")
//                                    .font(.title)
//                                    .fontWeight(.bold)
//                                    .padding(.leading)
//                                Button(action: {
//                                    withAnimation {
//                                        self.showPlaylists.toggle()
//                                    }
//                                }) {
//                                    Image(systemName: "chevron.right.circle")
//                                        .imageScale(.large)
//                                        .rotationEffect(.degrees(showPlaylists ? 90 : 0))
//                                        .scaleEffect(showPlaylists ? 1.2 : 1)
//                                        .padding()
//                                }
//                                Spacer()
//                                Button(action: {
//                                    self.showAddPlaylist = true
//                                }, label: {
//                                    HStack {
//                                        Text("Aggiungi scaletta")
//                                        Image(systemName: "plus")
//                                    }
//                                })
//                                .padding(.horizontal)
//                            }
//                            .sheet(isPresented: $showAddPlaylist) {
//                                AddPlaylistView()
//                            }
//
//                            if showPlaylists {
//                                ScrollView(.horizontal, showsIndicators: false) {
//                                    HStack(spacing: 0) {
//                                        ForEach(playlists.getPlaylists(), id: \.self) {playlist in
//                                            NavigationLink(destination: PlaylistView(playlistName: playlist)) {
//                                                TileView(name: playlist)
//                                                    .frame(minWidth: 150)
//                                            }
//                                            .contextMenu(menuItems: {
//                                                Button(action: {
//                                                    self.showActionSheet.toggle()
//                                                        }) {
//                                                            Text("Red")
//                                                        }
//                                            })
//                                            .popover(isPresented: $showActionSheet, attachmentAnchor: .point(.top), arrowEdge: .bottom) {
//                                                DetailChordView(chord: Chord.si)
//                                            }
//                                        }
//                                    }
//                                    .frame(maxHeight: 40)
//                                }
//                            }
//                        }
//                        Spacer()
//                    }
//                }
//                .onTapGesture {
//                    self.selectedTab = "All"
//                }
                SongList()
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Canti")
                }
                .tag("All")
                
                RecentlyPlayedView()
                    .tabItem {
                        Image(systemName: "play.fill")
                        Text("Recenti")
                    }
                    .tag("Recenti")
                
                CategoriesView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Categorie")
                    }
                    .tag("Categorie")
                
                PlaylistsView()
                    .tabItem {
                        Image(systemName: "folder.fill")
                        Text("Scalette")
                    }
                    .tag("Scaletta")
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Impostazioni")
                    }
                    .tag("Impostazioni")
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Settings())
            .environmentObject(RecentlyPlayedSongs())
    }
}

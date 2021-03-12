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
    
    @State private var selectedTab = "All"
	
    var body: some View {
            TabView(selection: $selectedTab) {
                
                MainSongListView()
                    .tabItem {
                        Image(systemName: "music.note.list")
                        Text("Canti")
                    }
                    .tag("All")
                
                RecentlyPlayedView()
                    .tabItem {
                        Image(systemName: "clock")
                        Text("Recenti")
                    }
                    .tag("Recenti")
                
                CategoriesView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Categorie")
                    }
                    .tag("Categorie")
                
                PlaylistsView()
                    .tabItem {
                        Image(systemName: "folder")
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
            .environmentObject(SongSettings())
            .environmentObject(RecentlyPlayedSongs())
            .environmentObject(Favorites())
            .environmentObject(Playlists())
            .environmentObject(UserNotes())
    }
}

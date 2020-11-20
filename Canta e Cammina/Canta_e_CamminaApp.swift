//
//  Canta_e_CamminaApp.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 20/08/20.
//

import SwiftUI

@main
struct Canta_e_CamminaApp: App {
    let persistenceController = PersistenceController.shared
	@ObservedObject var favorites = Favorites()
	@ObservedObject var settings = Settings()
    @ObservedObject var recentlyPlayed = RecentlyPlayedSongs()
    @ObservedObject var playlists = Playlists()
    @ObservedObject var userNotes = UserNotes()

    var body: some Scene {
        WindowGroup {
			HomeView()
				.environmentObject(favorites)
				.environmentObject(settings)
                .environmentObject(recentlyPlayed)
                .environmentObject(playlists)
                .environmentObject(userNotes)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

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

    var body: some Scene {
        WindowGroup {
			HomeView()
				.environmentObject(favorites)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
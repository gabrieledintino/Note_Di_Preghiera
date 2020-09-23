//
//  Favorites.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

class Favorites: ObservableObject, Codable {
	// the actual resorts the user has favorited
	private var songs: Set<String>

	// the key we're using to read/write in UserDefaults
	static private let saveKey = "Favorites"

	init() {
		let decoder = JSONDecoder()
		if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
			if let decoded = try? decoder.decode(Set<String>.self, from: data) {
				songs = decoded
				return
			}
		}
		// still here? Use an empty array
		self.songs = []
	}

	// returns true if our set contains this resort
	func contains(_ song: Song) -> Bool {
		songs.contains(song.title)
	}

	// adds the resort to our set, updates all views, and saves the change
	func add(_ song: Song) {
		objectWillChange.send()
		songs.insert(song.title)
		save()
	}

	// removes the resort from our set, updates all views, and saves the change
	func remove(_ song: Song) {
		objectWillChange.send()
		songs.remove(song.title)
		save()
	}

	func save() {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(songs) {
			UserDefaults.standard.set(encoded, forKey: Self.saveKey)
		}
	}
}

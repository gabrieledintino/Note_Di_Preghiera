//
//  Settings.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 10/09/20.
//

import SwiftUI

class SongSettings: ObservableObject, Codable {
	// define a dictionary with song name and the offset of the chords
	private var chordOffset: [String: Int]
	
	// the key we're using to read/write in UserDefaults
	static private let saveKey = "Settings"
    
    var chantMode: Bool = false
	
	init() {
		let decoder = JSONDecoder()
		if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
			if let decoded = try? decoder.decode([String: Int].self, from: data) {
				chordOffset = decoded
				return
			}
		}
		// still here? Use an empty dictionary
		chordOffset = [:]
	}
	
	// returns the offset associated with the song, or 0 if there is no offset
	func getOffset(_ song: Song) -> Int {
		if let offset = chordOffset[song.title] {
			return offset
		} else {
			chordOffset[song.title] = 0
			save()
			return 0
		}
	}

	func modifyOffset(_ song: Song, offset: Int) {                                  //FIXME: sistemare il save in modo che non venga sempre effettuato (SongSettingsView andrà sistemata)
		objectWillChange.send()
		chordOffset[song.title] = offset
//		save()
	}
    
    func saveOffset() {
        save()
    }
	
	private func save() {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(chordOffset) {
			UserDefaults.standard.set(encoded, forKey: Self.saveKey)
		}
	}
    
    func getMode() -> Bool {
        return chantMode
    }

    func chantModeToggle() {
        objectWillChange.send()
        self.chantMode.toggle()
    }
}

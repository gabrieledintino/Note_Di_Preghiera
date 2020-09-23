//
//  LastPlayedSongs.swift
//  Canta e Cammina
//
//  Created by Gabriele on 23/09/2020.
//

import SwiftUI

class RecentlyPlayedSongs: ObservableObject {
    // an array containing the last songs played
    private var recentlyPlayedSongs: [Song]
    
    static let saveKey = "LastPlayed"
    static private var maxArraySize = 5
    
    init() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? decoder.decode([Song].self, from: data) {
                self.recentlyPlayedSongs = decoded
                return
            }
        }
        // still here? Return an empty array
        recentlyPlayedSongs = []
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recentlyPlayedSongs) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func getRecentlyPlayed() -> [Song] {
        return recentlyPlayedSongs
    }
    
    func add(_ song: Song) {
        objectWillChange.send()
        if recentlyPlayedSongs.contains(song) { return }
        recentlyPlayedSongs.insert(song, at: 0)
        if recentlyPlayedSongs.count > Self.maxArraySize {
            recentlyPlayedSongs.removeLast()
        }
        save()
    }
}

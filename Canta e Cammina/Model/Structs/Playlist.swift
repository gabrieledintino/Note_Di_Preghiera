//
//  Playlist.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/10/2020.
//

import SwiftUI

struct Playlist: Codable, Hashable, Identifiable {
    init(name: String, songs: [Song]) {
        self.id = UUID()
        self.name = name
        self.songs = songs
    }
    
    let id: UUID
    private var name: String
    private var songs: [Song]
    
    
    
    func getName() -> String {
        return self.name
    }
    
    func getSongs() -> [Song] {
        return self.songs
    }
    
    mutating func addSong(song: Song) {
        self.songs.append(song)
    }
    
    mutating func addSongs(songs: [Song]) {
        self.songs.append(contentsOf: songs)
    }
    
    mutating func replaceSongs(songs: [Song]) {
        self.songs = []
        self.songs.append(contentsOf: songs)
    }
    
    mutating func deleteSong(song: Song) {
        self.songs.removeElement(element: song)
    }
    
    mutating func removeFromPlaylist(atOffsets offsets: IndexSet) {
        self.songs.remove(atOffsets: offsets)
    }
    
    mutating func moveSongs(from source: IndexSet, to destination: Int) {
        self.songs.move(fromOffsets: source, toOffset: destination)
    }
    
    mutating func renamePlaylist(to name: String) {
        self.name = name
    }
    
    mutating func contains(song: Song) -> Bool {
        return self.songs.contains(song)
    }
}

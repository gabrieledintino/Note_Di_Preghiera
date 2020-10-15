//
//  Playlist.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/10/2020.
//

import SwiftUI

class PlaylistClass: Codable, Identifiable {
    
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
    
     func addSong(song: Song) {
        self.songs.append(song)
    }
    
     func addSongs(songs: [Song]) {
        self.songs.append(contentsOf: songs)
    }
    
     func replaceSongs(songs: [Song]) {
        self.songs = []
        self.songs.append(contentsOf: songs)
    }
    
     func deleteSong(song: Song) {
        self.songs.removeElement(element: song)
    }
    
     func removeFromPlaylist(atOffsets offsets: IndexSet) {
        self.songs.remove(atOffsets: offsets)
    }
    
     func moveSongs(from source: IndexSet, to destination: Int) {
        self.songs.move(fromOffsets: source, toOffset: destination)
    }
    
     func renamePlaylist(to name: String) {
        self.name = name
    }
    
     func contains(song: Song) -> Bool {
        return self.songs.contains(song)
    }
}

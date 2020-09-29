//
//  Playlists.swift
//  Canta e Cammina
//
//  Created by Gabriele on 26/09/2020.
//

import SwiftUI

class Playlists: ObservableObject, Codable {
    // define a dictionary with playlist name and the songs of such playlist
    private var playlists: [String: [String]]
    
    // the key we're using to read/write in UserDefaults
    static private let saveKey = "Playlists"
    
    init() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? decoder.decode([String: [String]].self, from: data) {
                self.playlists = decoded
                return
            }
        }
        // still here? Use an empty dictionary
        self.playlists = [:]
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(playlists) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func getPlaylists() -> [String] {
        var playlistNames: [String] = []
        for name in playlists.keys {
            playlistNames.append(name)
        }
        return playlistNames
    }
    
    func getPlaylistSongs(playlistName: String) -> [String] {
        if let songs = playlists[playlistName] {
            return songs
        }
        return []
    }
    
    func createPlaylist(playlistName: String, songs: [String]) {
        objectWillChange.send()
        playlists[playlistName] = songs
        playlists.reserveCapacity(20)
        save()
    }
    
    func addToPlaylist(song: Song, playlistName: String) {
        objectWillChange.send()
        playlists[playlistName]?.append(song.title)
        save()
    }
    
    func removeFromPlaylist(song: Song, playlistName: String) {
        objectWillChange.send()
        playlists[playlistName]?.removeElement(element: song.title)
        save()
    }
    func removeFromPlaylist(atOffsets offsets: IndexSet, playlistName: String) {
        objectWillChange.send()
        playlists[playlistName]?.remove(atOffsets: offsets)
        save()
    }
    
    func moveSongs(from source: IndexSet, to destination: Int, playlistName: String) {
        objectWillChange.send()
        playlists[playlistName]?.move(fromOffsets: source, toOffset: destination)
        save()
    }
    
    func renamePlaylist(oldName: String, newName: String) {
        objectWillChange.send()
        playlists.changeKey(from: oldName, to: newName)
    }
    
    func contains(song: Song, playlistName: String) -> Bool {
        if let isContained = playlists[playlistName]?.contains(song.title) {
            return isContained
        } else {
            return false
        }
    }
    
}

//
//  Playlists.swift
//  Canta e Cammina
//
//  Created by Gabriele on 26/09/2020.
//

import SwiftUI

class Playlistsss: ObservableObject, Codable {
    // define a dictionary with playlist name and the songs of such playlist
    private var playlists: [String: [Song]]
    
    // the key we're using to read/write in UserDefaults
    static private let saveKey = "Playlists"
    
//    init() {
//        let decoder = JSONDecoder()
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//            if let decoded = try? decoder.decode([String: [String]].self, from: data) {
//                self.playlists = decoded
//                return
//            }
//        }
//        // still here? Use an empty dictionary
//        self.playlists = [:]
//    }
    init() {
        if let data: [String: [Song]] = FileManager().loadFromApplicationSupport(withName: Self.saveKey) {
            self.playlists = data
            return
        }
        // still here? Use an empty dictionary
        self.playlists = [:]
    }
    
//    func save() {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(playlists) {
//            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
//        }
//    }
    func save() {
        FileManager().saveToApplicationSupport(playlists, withName: Self.saveKey)
    }
    
    func getPlaylists() -> [String] {
        var playlistNames: [String] = []
        for name in playlists.keys {
            playlistNames.append(name)
        }
        return playlistNames
    }
    
    func getPlaylistSongs(playlistName: String) -> [Song] {
        if let songs = playlists[playlistName] {
            return songs
        }
        return []
    }
    
    func createPlaylist(playlistName: String, songs: [Song]) {
        objectWillChange.send()
        playlists[playlistName] = songs
        playlists.reserveCapacity(20)
        save()
    }
    
    func addToPlaylist(playlistName: String, song: Song) {
        objectWillChange.send()
        playlists[playlistName]?.append(song)
        save()
    }
    func addToPlaylist(playlistName: String, songs: [Song]) {
        objectWillChange.send()
        playlists[playlistName]?.append(contentsOf: songs)
        save()
    }
    
    func replaceSongsInPlaylist(playlistName: String, songs: [Song]) {
        objectWillChange.send()
        playlists[playlistName] = songs
        save()
    }
    
    func removeFromPlaylist(playlistName: String, song: Song) {
        objectWillChange.send()
        playlists[playlistName]?.removeElement(element: song)
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
        save()

    }
    
    func contains(song: Song, playlistName: String) -> Bool {
        if let isContained = playlists[playlistName]?.contains(song) {
            return isContained
        } else {
            return false
        }
    }
    
}

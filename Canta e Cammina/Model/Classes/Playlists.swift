//
//  Playlists.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/10/2020.
//

import SwiftUI

class Playlists: ObservableObject {
    // define a dictionary with playlist name and the songs of such playlist
    @Published private(set) var playlists: [PlaylistClass]
    
    // the key we're using to read/write in UserDefaults
    static private let saveKey = "Playlists"
    
    init() {
        if let data: [PlaylistClass] = FileManager().loadFromApplicationSupport(withName: Self.saveKey) {
            self.playlists = data
            return
        }
        // still here? Use an empty dictionary
        self.playlists = []
    }
    
    func save() {
        FileManager().saveToApplicationSupport(playlists, withName: Self.saveKey)
    }
    
    func getPlaylists() -> [PlaylistClass] {
        return self.playlists
    }
    
    func getPlaylistNames() -> [String] {
        return playlists.map { $0.getName()}
    }
    
    func getPlaylistSongs(playlistName: String) -> [Song] {
        if let playlist = playlists.first(where: { $0.getName() == playlistName }) {
            return playlist.getSongs()
        }
        return []
    }
    
    func createPlaylist(playlistName: String, songs: [Song]) {
        objectWillChange.send()
        let newPlaylist = PlaylistClass(name: playlistName, songs: songs)
        playlists.append(newPlaylist)
        save()
    }
    
    func addToPlaylist(playlistName: String, song: Song) {
        objectWillChange.send()
        if let playlist = playlists.first(where: { $0.getName() == playlistName }) {
            playlist.addSong(song: song)
        }
        save()
    }
    func addToPlaylist(playlistName: String, songs: [Song]) {
        objectWillChange.send()
        if let playlist = playlists.first(where: { $0.getName() == playlistName }) {
            playlist.addSongs(songs: songs)
        }
        save()
    }
    
    func replaceSongsInPlaylist(playlistName: String, songs: [Song]) {
        objectWillChange.send()
        if let playlist = playlists.first(where: { $0.getName() == playlistName }) {
            playlist.replaceSongs(songs: songs)
        }
        save()
    }
    
    func removeFromPlaylist(playlistName: String, song: Song) {
        objectWillChange.send()
        if let playlist = playlists.first(where: { $0.getName() == playlistName }) {
            playlist.deleteSong(song: song)
        }
        save()
    }
    func removeFromPlaylist(atOffsets offsets: IndexSet, playlistName: String) {
        objectWillChange.send()
        if let playlist = playlists.first(where: { $0.getName() == playlistName }) {
            playlist.removeFromPlaylist(atOffsets: offsets)
        }
        save()
    }
    
    func moveSongs(from source: IndexSet, to destination: Int, playlistName: String) {
        objectWillChange.send()
        if let playlist = playlists.first(where: { $0.getName() == playlistName }) {
            playlist.moveSongs(from: source, to: destination)
        }
        save()
    }
    
    func renamePlaylist(playlistName: String, newName: String) {
        objectWillChange.send()
        if let playlist = playlists.first(where: { $0.getName() == playlistName }) {
            playlist.renamePlaylist(to: newName)
        }
        save()

    }
    
    func deletePlaylist(playlistName: String) {
        objectWillChange.send()
        if let deleteIndex = playlists.firstIndex(where: { $0.getName() == playlistName }) {
            self.playlists.remove(at: deleteIndex)
        }
        save()
    }
    
    func contains(song: Song, playlistName: String) -> Bool {
        if let playlist = playlists.first(where: { $0.getName() == playlistName }) {
            return playlist.contains(song: song)
        }
        return false
    }
    
}

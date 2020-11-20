//
//  UserNotes.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 20/11/20.
//

import SwiftUI

class UserNotes: ObservableObject, Codable {
    // define a dictionary with playlist name and the songs of such playlist
    private var userNotes: [String: String]
    
    // the key we're using to read/write in UserDefaults
    static private let saveKey = "UserNotes"
    
    init() {
        if let data: [String: String] = FileManager().loadFromApplicationSupport(withName: Self.saveKey) {
            self.userNotes = data
            return
        }
        // still here? Use an empty dictionary
        self.userNotes = [:]
    }
    
    func save() {
        FileManager().saveToApplicationSupport(userNotes, withName: Self.saveKey)
    }
    
    func getUserNote(song: String) -> String? {
        return userNotes[song]
    }
    
    func setNote(song: String, note: String) {
        objectWillChange.send()
        self.userNotes[song] = note
        save()
    }
}

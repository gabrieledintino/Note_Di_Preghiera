//
//  Song.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import Foundation

struct Song: Codable, Hashable {
	let title: String
	let intro: String?
	let notesAndLyrics: [String]
	let categories: [String]
	let otherNotes: String?
	
	
	static let allSongs: [Song] = Bundle.main.decode("songs.json")
	static let example = allSongs[0]
	
	var notes: [[String]] {
		var temp: [String] = []
		_ = stride(from: 0, through: notesAndLyrics.count - 1, by: 2).map { index in
			temp.append(notesAndLyrics[index])
		}
		return temp.map { obtainNotes(string: $0) }
	}
	
	var lyrics: [String] {
		var temp: [String] = []
		_ = stride(from: 1, through: notesAndLyrics.count - 1, by: 2).map { index in
			temp.append(notesAndLyrics[index])
		}
		return temp
	}
	
	
	
	func obtainNotes(string: String) -> [String] {
		let notesArray: [String] = string.split(separator: " ", omittingEmptySubsequences: true).map { String($0)}
		var counter = 0
		var whitespaces: [String] = []
		
		for elem in string {
			if elem == " " {
				counter = counter + 1
			} else {
				if counter == 0 { continue }
				whitespaces.append(String(repeating: " ", count: counter))
				counter = 0
			}
		}

		var output: [String] = []
		if string.hasPrefix(" ") {
			for index in 0..<whitespaces.count {
				output.append(whitespaces[index])
				output.append(notesArray[index])
			}
		} else {
			for index in 0..<notesArray.count {
				output.append(notesArray[index])
				if index > whitespaces.count - 1 { break }
				output.append(whitespaces[index])
			}
		}
		
		return output
	}
}

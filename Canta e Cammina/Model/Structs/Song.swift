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
//	let notesAndLyrics: [String]
    let notesAndLyrics: String

	let categories: [String]
	let otherNotes: String?
	
	
    static let allSongs: [Song] = Bundle.main.decode("songs2.json")
    static let allSongsOrdered: [Song] = allSongs.sorted {$0.title < $1.title}                      // create a variable with all the decoded songs.
	static let example = allSongs[0]
    
    static let allCategories = allSongs.flatMap( { $0.categories }).unique().sorted()               // create an array with all the possible categories of the loaded songs.
    
    
	
//	var notes: [[String]] {                                                                         // function to get the chords of the song
//		var temp: [String] = []
//		_ = stride(from: 0, through: notesAndLyrics.count - 1, by: 2).map { index in                // map the notesAndLyrics variable every two lines, to get only the chords and storing them in an array
//			temp.append(notesAndLyrics[index])
//		}
//		return temp.map { obtainNotes(string: $0) }                                                 // map the obtained array to have the different notes ready to be elaborated singularly
//	}
//
//	var lyrics: [String] {                                                                          // function to get the lyrics of the song
//		var temp: [String] = []
//		_ = stride(from: 1, through: notesAndLyrics.count - 1, by: 2).map { index in                // map the notesAndLyrics variable every two lines, to get only the lyrics and returning them in an array
//			temp.append(notesAndLyrics[index])
//		}
//		return temp
//	}
    lazy var lazyNotes: [[String]] = getNoteLines()
    
    func getNoteLines() -> [[String]] {
        let lines = notesAndLyrics.components(separatedBy: .newlines)
        var temp: [String] = []
        _ = stride(from: 0, through: lines.count - 1, by: 2).map { index in                // map the notesAndLyrics variable every two lines, to get only the chords and storing them in an array
            temp.append(lines[index])
        }
        return temp.map { getNotes(string: $0) }
    }
    
    var notes: [[String]] {                                                                         // function to get the chords of the song
        let lines = notesAndLyrics.components(separatedBy: .newlines)
        var temp: [String] = []
        _ = stride(from: 0, through: lines.count - 1, by: 2).map { index in                // map the notesAndLyrics variable every two lines, to get only the chords and storing them in an array
            temp.append(lines[index])
        }
        return temp.map { getNotes(string: $0) }                                                 // map the obtained array to have the different notes ready to be elaborated singularly
    }
    
    var lyrics: [String] {                                                                          // function to get the lyrics of the song
        let lines = notesAndLyrics.components(separatedBy: .newlines)
        var temp: [String] = []
        _ = stride(from: 1, through: lines.count - 1, by: 2).map { index in                // map the notesAndLyrics variable every two lines, to get only the lyrics and returning them in an array
            temp.append(lines[index])
        }
        return temp
    }
	
	
	func getNotes(string: String) -> [String] {                                                  // function to separate the chords of the song
		let notesArray: [String] = string.split(separator: " ", omittingEmptySubsequences: true).map { String($0)}
		var counter = 0
		var whitespaces: [String] = []
		
		for elem in string {                                                                        // every character of the string is analyzed; if there is a sequence of whitespaces, they are counted and stored in an array
			if elem == " " {
				counter = counter + 1
			} else {
				if counter == 0 { continue }
				whitespaces.append(String(repeating: " ", count: counter))
				counter = 0
			}
		}

		var output: [String] = []
		if string.hasPrefix(" ") {                                                                  // the correct array is returned: depending on the first character of the line, the note and the whitespaces get inserted in the array in the proper order
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

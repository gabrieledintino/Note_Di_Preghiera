//
//  Note.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 28/08/20.
//

import Foundation
import SwiftUI

struct Chord: Codable, Hashable {
	let chordName: String
	let image: String
	let description: String
	
	static let allChords: [Chord] = Bundle.main.decode("chords.json")	// get all the chord types
	static let example = allChords[0]
	
	static let `do` = Chord(chordName: "DO", image: "DO", description: "Descrizione del DO")
	static let re = Chord(chordName: "RE", image: "RE", description: "Descrizione del RE")
	static let mi = Chord(chordName: "MI", image: "MI", description: "Descrizione del MI")
	static let fa = Chord(chordName: "FA", image: "FA", description: "Descrizione del FA")
	static let sol = Chord(chordName: "SOL", image: "SOL", description: "Descrizione del SOL")
	static let la = Chord(chordName: "LA", image: "LA", description: "Descrizione del LA")
	static let si = Chord(chordName: "SI", image: "SI", description: "Descrizione del SI")

	
	enum ChordBaseType: String {				// define all the base chord types
		case DO = "DO"
		case RE = "RE"
		case MI = "MI"
		case FA = "FA"
		case SOL = "SOL"
		case LA = "LA"
		case SI = "SI"
	}
	
	
	static func obtainChord(note: String) -> Chord {
//		var suffix = note[note.count-2...note.count-1]
		let prefix = note[0..<2]
		

		
		let chord = Chord.allChords.first(where: { $0.chordName == note }) ?? getDefaultChord(prefix: prefix)
		return chord
	}
	
	static func getDefaultChord(prefix: String) -> Chord {
		let chord = ChordBaseType(rawValue: prefix)
		switch chord {						//
		case .DO:
			return Chord.allChords[0]
		case .RE:
			return Chord.allChords[1]
		case .MI:
			return Chord.allChords[2]
		case .FA:
			return Chord.allChords[3]
		case .SOL:
			return Chord.allChords[4]
		case .LA:
			return Chord.allChords[5]
		case .SI:
			return Chord.allChords[6]
		case .none:
			return Chord.allChords[0]
		}
	}
}

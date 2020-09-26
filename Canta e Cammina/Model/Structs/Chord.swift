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
	
	static let allChords: [[Chord]] = Bundle.main.decode("chords.json")	// get all the chord types
	static let exampleSeries = allChords[0]
	static let exampleChord = allChords[0][0]
	
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
	
	// posso creare uno switch per ottenere l'array corretto, controllando con .contains se una nota ha la "m", un numero, o entrambi, e restituendo l'array corretto.
	
	static func getCorrectChords(chord: String) -> [Chord] {
		switch chord {
		case let x where x.contains("-") && x.contains("2"):
			return allChords[8]
		case let x where x.contains("-") && x.contains("3"):
			return allChords[9]
		case let x where x.contains("-") && x.contains("4"):
			return allChords[10]
		case let x where x.contains("-") && x.contains("5"):
			return allChords[11]
		case let x where x.contains("-") && x.contains("6"):
			return allChords[12]
		case let x where x.contains("-") && x.contains("7"):
			return allChords[13]
		case let x where x.contains("-"):
			return allChords[7]
        case let x where x.contains("+") && x.contains("2"):
            return allChords[15]
        case let x where x.contains("+") && x.contains("3"):
            return allChords[16]
        case let x where x.contains("+") && x.contains("4"):
            return allChords[17]
        case let x where x.contains("+") && x.contains("5"):
            return allChords[18]
        case let x where x.contains("+") && x.contains("6"):
            return allChords[19]
        case let x where x.contains("+") && x.contains("7"):
            return allChords[20]
        case let x where x.contains("+"):
            return allChords[14]
		case let x where x.contains("2"):
			return allChords[1]
		case let x where x.contains("3"):
			return allChords[2]
		case let x where x.contains("4"):
			return allChords[3]
		case let x where x.contains("5"):
			return allChords[4]
		case let x where x.contains("6"):
			return allChords[5]
		case let x where x.contains("7"):
			return allChords[6]
		default:
			return allChords[0]
		}
	}
	
	static func obtainChord(chord: String, offset: Int) -> Chord {
//		var suffix = note[note.count-2...note.count-1]
		let prefix = chord[0..<2]						// get the first two digits of the chord to extrapolate the chord to be used if proper chord can't be identified
		let chordArray = getCorrectChords(chord: chord)
        if let chordBaseIndex = chordArray.firstIndex(where: { $0.chordName == chord.uppercased() }) {
			return chordArray[(chordBaseIndex + offset) % chordArray.count]
		} else {
			let defaultChordBaseIndex = getDefaultChordIndex(prefix: prefix)
			return chordArray[(defaultChordBaseIndex + offset) % chordArray.count]
		}
	}
	
	private static func getDefaultChordIndex(prefix: String) -> Int {
		let chord = ChordBaseType(rawValue: prefix)
		switch chord {						//
		case .DO:
			return Chord.allChords[0].firstIndex(of: Self.do)!
		case .RE:
			return Chord.allChords[0].firstIndex(of: Self.re)!
		case .MI:
			return Chord.allChords[0].firstIndex(of: Self.mi)!
		case .FA:
			return Chord.allChords[0].firstIndex(of: Self.fa)!
		case .SOL:
			return Chord.allChords[0].firstIndex(of: Self.sol)!
		case .LA:
			return Chord.allChords[0].firstIndex(of: Self.la)!
		case .SI:
			return Chord.allChords[0].firstIndex(of: Self.si)!
		case .none:
			return Chord.allChords[0].firstIndex(of: Self.do)!
		}
	}
}

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
    static let allChords2: Set<Chord> = Bundle.main.decode("chords2.json")    // get all the chord types
	static let exampleSeries = allChords[0]
	static let exampleChord = allChords[0][0]
    
    static func obtainChord(chord: String, offset: Int) -> Chord {
        let uppercasedChord = chord.uppercased()
        let baseChords: [String] = ["DO", "DO#", "RE", "MIb", "MI", "FA", "FA#", "SOL", "SOL#", "LA", "SIb", "SI"]
        var prefixStringIndex: String.Index?
        if uppercasedChord.contains("#") {
            prefixStringIndex = uppercasedChord.index(after: uppercasedChord.firstIndex(of: "#")!)
        } else if uppercasedChord.contains("b") {
            prefixStringIndex = uppercasedChord.index(after: uppercasedChord.firstIndex(of: "b")!)
        } else if uppercasedChord.hasPrefix("SOL") {
            prefixStringIndex = uppercasedChord.index(after: uppercasedChord.lastIndex(of: "L")!)
        } else {
            prefixStringIndex = uppercasedChord.index(uppercasedChord.startIndex, offsetBy: 2)
        }
        
        let prefix = uppercasedChord.prefix(upTo: prefixStringIndex!)
        let suffix = uppercasedChord.suffix(from: prefixStringIndex!)
        let baseChordIndex: Int = baseChords.firstIndex(of: String(prefix))!
        let finalChordIndex = (baseChordIndex + offset) % baseChords.count
        let finalChordName: String = baseChords[finalChordIndex] + suffix
        return allChords2.first(where: { $0.chordName == finalChordName }) ?? Chord(chordName: finalChordName, image: finalChordName, description: "Nessuna descrizione")
        
    }
}

//extension Chord {
//
//    static let `do` = Chord(chordName: "DO", image: "DO", description: "Descrizione del DO")
//    static let re = Chord(chordName: "RE", image: "RE", description: "Descrizione del RE")
//    static let mi = Chord(chordName: "MI", image: "MI", description: "Descrizione del MI")
//    static let fa = Chord(chordName: "FA", image: "FA", description: "Descrizione del FA")
//    static let sol = Chord(chordName: "SOL", image: "SOL", description: "Descrizione del SOL")
//    static let la = Chord(chordName: "LA", image: "LA", description: "Descrizione del LA")
//    static let si = Chord(chordName: "SI", image: "SI", description: "Descrizione del SI")
//
//
//    enum ChordBaseType: String {                // define all the base chord types
//        case DO = "DO"
//        case RE = "RE"
//        case MI = "MI"
//        case FA = "FA"
//        case SOL = "SOL"
//        case LA = "LA"
//        case SI = "SI"
//    }
//
//    // posso creare uno switch per ottenere l'array corretto, controllando con .contains se una nota ha la "m", un numero, o entrambi, e restituendo l'array corretto.
//
//    private static func getCorrectChords(chord: String) -> [Chord] {
//        switch chord {
//        case _ where chord.contains("-") && chord.contains("2"):
//            return allChords[8]
//        case _ where chord.contains("-") && chord.contains("3"):
//            return allChords[9]
//        case _ where chord.contains("-") && chord.contains("4"):
//            return allChords[10]
//        case _ where chord.contains("-") && chord.contains("5"):
//            return allChords[11]
//        case _ where chord.contains("-") && chord.contains("6"):
//            return allChords[12]
//        case _ where chord.contains("-") && chord.contains("7"):
//            return allChords[13]
//        case _ where chord.contains("-"):
//            return allChords[7]
//        case _ where chord.contains("+") && chord.contains("2"):
//            return allChords[15]
//        case _ where chord.contains("+") && chord.contains("3"):
//            return allChords[16]
//        case _ where chord.contains("+") && chord.contains("4"):
//            return allChords[17]
//        case _ where chord.contains("+") && chord.contains("5"):
//            return allChords[18]
//        case _ where chord.contains("+") && chord.contains("6"):
//            return allChords[19]
//        case _ where chord.contains("+") && chord.contains("7"):
//            return allChords[20]
//        case _ where chord.contains("+"):
//            return allChords[14]
//        case _ where chord.contains("2"):
//            return allChords[1]
//        case _ where chord.contains("3"):
//            return allChords[2]
//        case _ where chord.contains("4"):
//            return allChords[3]
//        case _ where chord.contains("5"):
//            return allChords[4]
//        case _ where chord.contains("6"):
//            return allChords[5]
//        case _ where chord.contains("7"):
//            return allChords[6]
//        default:
//            return allChords[0]
//        }
//    }
//
//    static func obtainChord2(chord: String, offset: Int) -> Chord {
//        let prefix = chord[0..<2]                                            // get the first two digits of the chord to extrapolate the chord to be used if proper chord can't be identified
//        let chordArray = getCorrectChords(chord: chord)
//        if let chordBaseIndex = chordArray.firstIndex(where: { $0.chordName.uppercased() == chord.uppercased() }) {
//            return chordArray[(chordBaseIndex + offset) % chordArray.count]
//        } else {
//            let defaultChordBaseIndex = getDefaultChordIndex(prefix: prefix)
//            return chordArray[(defaultChordBaseIndex + offset) % chordArray.count]
//        }
//    }
//
//    private static func getDefaultChordIndex(prefix: String) -> Int {
//        let chord = ChordBaseType(rawValue: prefix.uppercased())
//        switch chord {
//        case .DO:
//            return Chord.allChords[0].firstIndex(of: Self.do)!
//        case .RE:
//            return Chord.allChords[0].firstIndex(of: Self.re)!
//        case .MI:
//            return Chord.allChords[0].firstIndex(of: Self.mi)!
//        case .FA:
//            return Chord.allChords[0].firstIndex(of: Self.fa)!
//        case .SOL:
//            return Chord.allChords[0].firstIndex(of: Self.sol)!
//        case .LA:
//            return Chord.allChords[0].firstIndex(of: Self.la)!
//        case .SI:
//            return Chord.allChords[0].firstIndex(of: Self.si)!
//        case .none:
//            return Chord.allChords[0].firstIndex(of: Self.do)!
//        }
//    }
//}

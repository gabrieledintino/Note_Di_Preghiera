//
//  Note.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 28/08/20.
//

import Foundation
import SwiftUI

struct Chord: Codable, Hashable {
	let chord: String
	let image: String
	let description: String
	
	static let allChords: [Chord] = Bundle.main.decode("chords.json")
	static let example = allChords[0]
	
	
}

//
//  NoteView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 22/08/20.
//

import SwiftUI

struct NoteView: View {
	var note: String
	@State private var isShowingNote = false
	
    var body: some View {
		ZStack {
			if !note.hasPrefix(" ") {
				Button(Chord.obtainChord(note: note).chordName) {
					self.isShowingNote = true
				}
			} else {
				Text(note)
			}
		}
		.popover(isPresented: $isShowingNote, content: {
			DetailNoteView(note: note)
		})
//		.sheet(isPresented: $isShowingNote) {
//			DetailNoteView(note: note)
//		}
    }
	
//	func obtainChord(name: String) -> Chord {
//		return Chord.allChords.first(where: { $0.chordName == note }) ?? Chord(chordName: "SI", image: "SI", description: "SI")
//	}
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: "SI DO")
    }
}

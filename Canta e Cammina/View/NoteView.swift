//
//  NoteView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 22/08/20.
//

import SwiftUI

struct NoteView: View {
	@State private var isShowingNote = false
	@EnvironmentObject var settings: Settings
	var note: String
	var song: Song
	
	var chord: Chord {
		Chord.obtainChord(note: note, offset: self.settings.getOffset(song))
	}
	
    var body: some View {
		VStack {
			if !note.hasPrefix(" ") {
                Button(chord.chordName) {
					self.isShowingNote = true
				}
                .animation(.spring())
			} else {
				Text(note)
                    .animation(.spring())
			}
		}
		.popover(isPresented: $isShowingNote, content: {
			DetailNoteView(chord: chord)
		})
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
		NoteView(note: "SI DO", song: Song.example)
    }
}

//
//  NoteView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 22/08/20.
//

import SwiftUI

struct ChordView: View {
	@State private var isShowingNote = false
	@EnvironmentObject var settings: Settings
	var chordString: String
	var song: Song
	
	var chord: Chord {
		Chord.obtainChord(chord: chordString, offset: self.settings.getOffset(song))
	}
	
    var body: some View {
		VStack {
			if !chordString.hasPrefix(" ") {
                Button(chord.chordName) {
					self.isShowingNote = true
				}
                .animation(.spring())
			} else {
				Text(chordString)
                    .animation(.spring())
			}
		}
		.popover(isPresented: $isShowingNote, content: {
			DetailChordView(chord: chord)
		})
    }
}

struct ChordView_Previews: PreviewProvider {
    static var previews: some View {
		ChordView(chordString: "SI DO", song: Song.example)
    }
}

//
//  NotesView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 22/08/20.
//

import SwiftUI

struct ChordsView: View {
	var chords: [String]
	var song: Song
	
    var body: some View {
		HStack(spacing: 0) {
				ForEach(chords, id: \.self) { chord in
					NoteView(chordString: chord, song: song)
				}
		}
    }
}

struct ChordsView_Previews: PreviewProvider {
    static var previews: some View {
		ChordsView(chords: ["SI", "   ", "LA", "DO"], song: Song.example)
    }
}

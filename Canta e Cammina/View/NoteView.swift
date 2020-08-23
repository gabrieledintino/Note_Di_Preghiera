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
				Button(note) {
					self.isShowingNote = true
				}
			} else {
				Text(note)
			}
		}
		.sheet(isPresented: $isShowingNote) {
			DetailNoteView(note: note)
		}
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: "SI DO")
    }
}

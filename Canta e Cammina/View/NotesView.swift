//
//  NotesView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 22/08/20.
//

import SwiftUI

struct NotesView: View {
	var notes: [String]
	
    var body: some View {
		HStack(spacing: 0) {
				ForEach(notes, id: \.self) { note in
					NoteView(note: note)
				}
		}
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(notes: ["SI", "   ", "LA", "DO"])
    }
}

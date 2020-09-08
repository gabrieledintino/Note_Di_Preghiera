//
//  DetailNoteView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 23/08/20.
//

import SwiftUI

struct DetailNoteView: View {
	@Environment(\.presentationMode) var presentationMode
	
	var note: String
	
    var body: some View {
		VStack {
			Image(note)
				.resizable()
				.scaledToFit()
				.frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
			
			Text(note)
				.font(.largeTitle)
			Text("Qui andrà una descrizione")
		}
		.frame(width: 400, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct DetailNoteView_Previews: PreviewProvider {
    static var previews: some View {
		DetailNoteView(note: "la")
    }
}

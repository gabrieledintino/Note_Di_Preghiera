//
//  DetailNoteView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 23/08/20.
//

import SwiftUI

struct DetailChordView: View {
	@Environment(\.presentationMode) var presentationMode
	
	var chord: Chord
	
    var body: some View {
		VStack {
            HStack {
                Spacer()
                Button("Fatto", action: dismiss)
            }
            Spacer()
            
			Image(chord.image)
				.resizable()
				.scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
                .background(Color.white)
                .cornerRadius(8)
			
			Text(chord.chordName)
				.font(.largeTitle)
                .foregroundColor(.accentColor)
			Text("Qui andrà una descrizione")
            Spacer()
		}
        .padding()
        .if(UIDevice.current.userInterfaceIdiom == .pad) {
            $0.frame(width: 400, height: 450, alignment: .center)
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailNoteView_Previews: PreviewProvider {
    static var previews: some View {
		DetailChordView(chord: Chord.exampleChord)
    }
}

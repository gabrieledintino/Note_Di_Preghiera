//
//  SongView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

struct SongView: View {
	var song: Song
	
	
    var body: some View {
//			GeometryReader { fullView in
					ScrollView(.vertical) {
						HStack {
							VStack(alignment: .leading, spacing: 5) {
								Text(song.title)
									.font(.title)
									.fontWeight(.bold)
									.padding(5)
								
								if song.intro != nil {
									Text(song.intro!)
								}
								ForEach(0..<song.notes.count) { index in
									NotesView(notes: song.obtainNotes(string: song.notes[index]))
//									Text(song.notes[index])
									Text(song.lyrics[index])
								}
							}
							.padding(.horizontal)
							
							Spacer()
						}
					}
//			}
		.navigationTitle(song.title)
		.navigationBarTitleDisplayMode(.inline)
		.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
		SongView(song: Song.example)
    }
}

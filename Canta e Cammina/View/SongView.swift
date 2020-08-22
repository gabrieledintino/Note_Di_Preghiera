//
//  SongView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

struct SongView: View {
	var song: Song
	
//	private var notes: [String] {
//		var temp: [String] = []
//		_ = stride(from: 0, through: song.notesAndLyrics.count - 1, by: 2).map { index in
//			temp.append(song.notesAndLyrics[index])
//		}
//		return temp
//	}
//
//	private var lyrics: [String] {
//		var temp: [String] = []
//		_ = stride(from: 1, through: song.notesAndLyrics.count - 1, by: 2).map { index in
//			temp.append(song.notesAndLyrics[index])
//		}
//		return temp
//	}

	
    var body: some View {
		NavigationView {
			GeometryReader { fullView in
					ScrollView(.vertical) {
						HStack {
							VStack(alignment: .leading, spacing: 5) {
								Text(song.title)
									.font(.title)
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
			}
		}
		.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
		SongView(song: Song.example)
			.padding()
    }
}

//
//  SongView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

struct SongView: View {
	@EnvironmentObject var favorites: Favorites
	@State private var showingSettings = false
	
	var song: Song
	
	
    var body: some View {
//			GeometryReader { fullView in
					ScrollView(.vertical) {
						HStack {
							VStack(alignment: .leading, spacing: 5) {
//								Text(song.title)
//									.font(.title)
//									.fontWeight(.bold)
//									.padding(5)
								
								if song.intro != nil {
									NotesView(notes: song.obtainNotes(string: song.intro!))
								}
								ForEach(0..<song.notes.count) { index in
									NotesView(notes: song.notes[index])
									
									if song.lyrics[index].hasPrefix("**") {
										Text(song.lyrics[index][2..<song.lyrics[index].count])
											.fontWeight(.bold)
									} else {
										Text(song.lyrics[index])
									}
								}
							}
							.padding(.horizontal)
							
							Spacer()
						}
					}
//			}
		.navigationTitle(song.title)
		.navigationBarTitleDisplayMode(.automatic)
		.navigationBarItems(trailing:
								HStack(spacing: 15) {
									Button {
										if self.favorites.contains(song) {
											self.favorites.remove(song)
										} else {
											self.favorites.add(song)
										}
										} label: {
											self.favorites.contains(song) ? Image(systemName: "heart.fill") : Image(systemName: "heart")
										}
										.foregroundColor(.red)
									
									Button {
										self.showingSettings = true
									} label: {
										Image(systemName: "gear")
									}
								})
		.navigationViewStyle(StackNavigationViewStyle())
		.background(EmptyView()
						.sheet(isPresented: $showingSettings) {
							// menù dei settaggi
						})
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
		SongView(song: Song.example)
    }
}

//
//  SongView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

struct SongView: View {
	@EnvironmentObject var favorites: Favorites
    @EnvironmentObject var settings: Settings
	@State private var showingSettings = false
	
	var song: Song
	
	
    var body: some View {
//			GeometryReader { fullView in
					ScrollView(.vertical) {
						HStack {
							VStack(alignment: .leading, spacing: 5) {
								if song.otherNotes != nil {
									Text(song.otherNotes!)
										.italic()
										.padding(.vertical)
								}
								if song.intro != nil {
									HStack {
										Text("Intro: ")
											.italic()
										NotesView(notes: song.obtainNotes(string: song.intro!), song: song)
									}
									.padding(.bottom)
								}
								ForEach(0..<song.notes.count) { index in
                                    
                                    if !settings.chantMode {
                                        NotesView(notes: song.notes[index], song: song)
                                    }
									obtainText(index: index)
                                        .animation(.spring())
                                    
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
										Image(systemName: "music.note")
										Text("Impostazioni")
									}
								})
		.navigationViewStyle(StackNavigationViewStyle())
		.background(EmptyView()
						.popover(isPresented: $showingSettings, attachmentAnchor: .point(.topTrailing), arrowEdge: .top) {
							SettingsView(song: song)
						})
    }
	
	func obtainText(index: Int) -> some View {
		if song.lyrics[index].hasPrefix("**") {
			return Text(song.lyrics[index][2..<song.lyrics[index].count])
				.fontWeight(.bold)
		} else {
			return Text(song.lyrics[index])
		}
	}
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
		SongView(song: Song.example)
    }
}

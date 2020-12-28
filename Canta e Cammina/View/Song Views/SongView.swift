//
//  SongView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

struct SongView: View {
	@EnvironmentObject var favorites: Favorites
    @EnvironmentObject var settings: SongSettings
    @EnvironmentObject var recentlyPlayed: RecentlyPlayedSongs
    @EnvironmentObject var userNotes: UserNotes
	@State private var showingSettings = false
    @State private var showingUserNoteField = false
    @State private var userNote = ""
	
	var song: Song
    var chords: [[String]]
    
    init(_ newSong: Song) {
        self.song = newSong
        self.chords = newSong.notes
    }
	
    var body: some View {
//			GeometryReader { fullView in
					ScrollView(.vertical) {
						HStack {
							VStack(alignment: .leading, spacing: 5) {
                                if showingUserNoteField {
                                    TextField("Inserisci qui una nota", text: $userNote, onCommit: { userNotes.setNote(song: song.title, note: userNote); withAnimation(.default) {
                                        self.showingUserNoteField = false
                                    } })
                                        .padding(7)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                }
                                
                                if userNotes.getUserNote(song: song.title) != nil {
                                    Text(userNotes.getUserNote(song: song.title)!)
                                        .italic()
                                        .foregroundColor(.green)
                                        .padding(.vertical, 10)
                                        .onTapGesture {
                                            withAnimation(.default) {
                                                self.showingUserNoteField.toggle()
                                            }
                                        }
                                }
                                
								ForEach(0..<song.notes.count) { index in
                                    if !settings.chantMode {
                                        ChordsView(chords: chords[index], song: song)
                                    }
									obtainText(index: index)
                                        .lineLimit(6)
                                        .allowsTightening(true)
                                        .animation(.spring())
                                        .offset(x: 0, y: -4)
								}
                                Spacer(minLength: 10)
                                
                                if let youtubeLink = song.link {
                                    HStack {
                                        Image("YouTubeIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        Link("Guarda su YouTube", destination: URL(string: youtubeLink)!)
                                    }
                                    .padding(.bottom, 10)
                                }
							}
							.padding(.horizontal)
							
							Spacer()
						}
                    }.onAppear(perform: {
                        self.recentlyPlayed.add(song)
                        self.userNote = userNotes.getUserNote(song: song.title) ?? ""
                    })
//			}
		.navigationTitle(song.title)
		.navigationBarTitleDisplayMode(.automatic)
        .navigationViewStyle(StackNavigationViewStyle())
//		.navigationBarItems(trailing:
//								HStack(spacing: 15) {
//									Button {                                    //MARK: Favorites
//										if self.favorites.contains(song) {
//											self.favorites.remove(song)
//										} else {
//											self.favorites.add(song)
//										}
//										} label: {
//											self.favorites.contains(song) ? Image(systemName: "heart.fill") : Image(systemName: "heart")
//										}
//										.foregroundColor(.red)
//
//                                    Button {                                    //MARK: User note
//                                        withAnimation(.default) {
//                                            self.showingUserNoteField.toggle()
//                                        }
//                                    } label: {
//                                        Image(systemName: showingUserNoteField ? "text.bubble.fill" : "text.bubble")
//                                    }
//
//                                    Button {                                    //MARK: Settings
//                                        self.showingSettings = true
//                                    } label: {
//                                        Image(systemName: "music.note.list")
//                                    }
//                                    .buttonStyle(PlainButtonStyle())
//                                    .popover(isPresented: $showingSettings, attachmentAnchor: .point(.topTrailing), arrowEdge: .top) {
//                                        SongSettingsView(song: song)
//                                    }
//								})
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {                                            //MARK: Favorites
                    if self.favorites.contains(song) {
                        self.favorites.remove(song)
                    } else {
                        self.favorites.add(song)
                    }
                    } label: {
                        self.favorites.contains(song) ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                    }
                .foregroundColor(.red)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {                                            //MARK: User note
                        withAnimation(.default) {
                            self.showingUserNoteField.toggle()
                        }
                    } label: {
                        Image(systemName: showingUserNoteField ? "text.bubble.fill" : "text.bubble")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {                                            //MARK: SongSettings
                    self.showingSettings = true
                } label: {
                    Image(systemName: "music.note.list")
                }
            }
        }
        .background(EmptyView()
                        .popover(isPresented: $showingSettings, attachmentAnchor: .point(.topTrailing), arrowEdge: .top) {
                            SongSettingsView(showSettingsView: $showingSettings, song: song)
                        }
        )

    }
	
	func obtainText(index: Int) -> some View {
        if (index >= song.lyrics.count) {
            print("ERROR")
            return Text("ERRORE DI LINEA")
        }
		if song.lyrics[index].hasPrefix("**") {
			return Text(song.lyrics[index][2..<song.lyrics[index].count])
				.fontWeight(.bold)
		} else if song.lyrics[index].hasPrefix("||") {
            return Text(song.lyrics[index][2..<song.lyrics[index].count])
                .italic()
        } else {
			return (Text(song.lyrics[index]))
		}
	}
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
		SongView(Song.example)
    }
}

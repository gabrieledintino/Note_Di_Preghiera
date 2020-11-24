//
//  TestView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 04/10/2020.
//

import SwiftUI

struct AddSongView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var favorites: Favorites
    @EnvironmentObject var playlists: Playlists
    var songs: [Song] {
        Song.allSongsOrdered.filter { !playlistContent.contains($0) }
    }
    @State private var songsToAdd: [Song] = []
    @State private var searchText = ""
    var playlistName: String
    var playlistContent: [Song] {
        playlists.getPlaylistSongs(playlistName: playlistName)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.top, 10)

                List(songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) }), id: \.self) { song in
                    VStack(alignment: .leading) {
                        Text(song.title)
                            .font(.headline)
                    }.layoutPriority(1)
                    
                    Spacer()

                    FavoriteHeart(song: song)
                    
                    if let index = songsToAdd.firstIndex(of: song) {
                        Text("\(index + 1)")
                            .foregroundColor(Color(.systemGray))
                    }
                    
                    Button(action: {                                                    //MARK: button to add songs
                            if songsToAdd.contains(song) {
                                    songsToAdd.removeElement(element: song)
                            } else {
                                    songsToAdd.append(song)
                            }
                    }, label: {
                        Image(systemName: songsToAdd.contains(song) ? "minus.circle.fill" : "plus.circle.fill")
                            .animation(.default)
                            .foregroundColor(songsToAdd.contains(song) ? Color.red : Color.green)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationTitle("Aggiungi canzoni")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla", action: dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fatto", action: addAndDismiss)
                }
            }
        }
//        .background(VisualEffectView(effect: UIBlurEffect(style: .dark)))
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    func addAndDismiss() {
        playlists.addToPlaylist(playlistName: playlistName, songs: songsToAdd)
        dismiss()
    }
}
    
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct AddSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddSongView(playlistName: "Prova")
            .environmentObject(Favorites())
            .environmentObject(Playlists())
    }
}

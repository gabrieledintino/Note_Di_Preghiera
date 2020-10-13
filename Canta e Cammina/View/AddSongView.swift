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
        VStack {
            HStack {
                Spacer()
                Button("Fatto", action: dismiss)
            }
            SearchBar(text: $searchText)
                .padding(.top, 10)

            List(songs.filter({ searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) }), id: \.self) { song in
                VStack(alignment: .leading) {
                    Text(song.title)
                        .font(.headline)
                }.layoutPriority(1)
                
                Spacer()

                if self.favorites.contains(song) {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite song"))
                        .foregroundColor(.red)
                        .padding(.horizontal, 5)
                }
                
                if let index = songsToAdd.firstIndex(of: song) {
                    Image(systemName: "\(index + 1).circle")
                        .foregroundColor(.blue)
                    Text("\(index + 1)")
                        .foregroundColor(.blue)

                }
                
                Button(action: {
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
            Button(action: {
                playlists.addToPlaylist(playlistName: playlistName, songs: songsToAdd)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Text("Fatto")
                        .padding(.horizontal)
                    Image(systemName: "checkmark")
                }
                .padding(10)
            })
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
//        .frame(maxWidth: .infinity)
//        .background(VisualEffectView(effect: UIBlurEffect(style: .dark)))
//        .edgesIgnoringSafeArea(.vertical)
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
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
    }
}

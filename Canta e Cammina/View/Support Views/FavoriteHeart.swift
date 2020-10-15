//
//  FavoriteHeart.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/10/2020.
//

import SwiftUI

struct FavoriteHeart: View {
    @EnvironmentObject var favorites: Favorites
    var song: Song
    
    var body: some View {
        Group {
            if self.favorites.contains(song) {
                Spacer()
                Image(systemName: "heart.fill")
                    .accessibility(label: Text("This is a favorite song"))
                    .foregroundColor(.red)
                    .padding(.horizontal, 10)
            }
        }
    }
}

struct FavoriteHeart_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteHeart(song: Song.example)
    }
}

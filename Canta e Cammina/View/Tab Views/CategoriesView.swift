//
//  CategoriesView.swift
//  Canta e Cammina
//
//  Created by Gabriele on 14/10/2020.
//

import SwiftUI

struct CategoriesView: View {
    let songs = Song.allSongsOrdered
    
    let columns: [GridItem] = [
        GridItem(.flexible(minimum: 50, maximum: 400), spacing: 10, alignment: .center),
        GridItem(.flexible(minimum: 50, maximum: 400), spacing: 0, alignment: .center),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                        ForEach(Song.allCategories, id: \.self) { category in
                            NavigationLink(destination: ListView(songs: songs, category: category)) {
                                GroupBox(
                                    label: Label("", systemImage: "square.grid.3x3.topleft.fill")
                                        .foregroundColor(.red)
                                        .font(.callout)
                                        .padding(.bottom, 1)
                                ) {
                                    Text(category)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                } .groupBoxStyle(CardGroupBoxStyle())
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Categorie")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}

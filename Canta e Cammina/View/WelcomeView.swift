//
//  WelcomeView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 21/08/20.
//

import SwiftUI

struct WelcomeView: View {
	var body: some View {
		VStack {
			Text("Benvenuto a Canta e Cammina!")
				.font(.largeTitle)

			Text("Seleziona un canto dal menù a sinistra; scorri dal bordo sinistro dello schermo per mostrarlo")
				.foregroundColor(.secondary)
		}
	}
}

struct WelcomeView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomeView()
	}
}

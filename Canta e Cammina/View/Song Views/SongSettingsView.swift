//
//  SettingsView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 11/09/20.
//

import SwiftUI

struct SongSettingsView: View {
	@EnvironmentObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode
	var song: Song
	@State private var selectedOffset = 0
	var offsets = ["0", "0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5"]
    @State private var chantMode = false
	
    var body: some View {
		let offset = Binding<Int>(
			get: { self.selectedOffset },
			set: {
				self.selectedOffset = $0
				self.settings.modifyOffset(song, offset: $0)
			})
        
        let bind = Binding<Bool>(
                  get:{self.chantMode},
                  set:{self.chantMode = $0
                    self.settings.chantModeToggle()
                  }
                )
		
		VStack {
            HStack {
                Spacer()
                Button("Fatto", action: dismiss)
            }
            Spacer()
            
            Button("Azzera toni") { withAnimation {
//                selectedOffset = 0
                offset.wrappedValue = 0
            } }
			Picker(selection: offset, label: Text("Seleziona di quanto vuoi variare i toni")) {
				ForEach(0..<offsets.count) {
					Text(self.offsets[$0])
				}
			}
//			.pickerStyle(SegmentedPickerStyle())
			Text("Hai selezionato \(offsets[selectedOffset]) toni in più")
            
            Toggle("Modalità canto", isOn: bind)

		}
        .padding()
//		.frame(width: 300, height: 300, alignment: .center)
        .onAppear(perform: { readOffset(song: song); readChantMode() })
    }
	
	func readOffset(song: Song) {
		self.selectedOffset = self.settings.getOffset(song)
	}
    func readChantMode() {
        self.chantMode = self.settings.getMode()
    }
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SongSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SongSettingsView(song: Song.example)
    }
}

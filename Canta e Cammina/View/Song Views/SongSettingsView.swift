//
//  SettingsView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 11/09/20.
//

import SwiftUI

struct SongSettingsView: View {
	@EnvironmentObject var songSettings: SongSettings
    @Environment(\.presentationMode) var presentationMode
    @Binding var showSettingsView: Bool
    @State private var selectedOffset = 0
    @State private var originalOffset = 0
    var song: Song
	var offsetsString = ["0", "0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5"]
    @State private var chantMode = false
    @State private var modified = false
    @State private var firstDisappear = true
	
    var body: some View {
		let offset = Binding<Int>(
			get: { self.selectedOffset },
			set: {
				self.selectedOffset = $0
				self.songSettings.modifyOffset(song, offset: $0)
			})
        
        let bind = Binding<Bool>(
                  get:{self.chantMode},
                  set:{self.chantMode = $0
                    self.songSettings.chantModeToggle()
                  }
                )
		
        NavigationView {
            Form {
                Section(header: Text("Toni dei canti")) {
                    Button("Azzera toni") { withAnimation {
                        offset.wrappedValue = 0
                    } }
                    Picker(selection: offset, label: Text("Seleziona di quanto vuoi variare i toni")) {
                        ForEach(0..<offsetsString.count) {
                            Text(self.offsetsString[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    Text("Hai selezionato \(offsetsString[selectedOffset]) toni in più")
                }

                Section(header: Text("Altre impostazioni")) {
                        Toggle("Modalità canto", isOn: bind)
                    }
            }
            .onAppear(perform: { readOffset(song: song); readChantMode() })
            .onDisappear(perform: {
                if !firstDisappear {
                    print("Scopacane")
                    cancel()
                }
                self.firstDisappear = false
            })
            .navigationTitle("Impostazioni")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salva", action: saveAndDismiss)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { cancelAndDismiss() }, label: {
                        Text("Annulla")
                    })
                }
            }
        }
        .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity, minHeight: 400, idealHeight: 600, maxHeight: .infinity, alignment: .center)
    }
    
	
	func readOffset(song: Song) {
		self.selectedOffset = self.songSettings.getOffset(song)
        self.originalOffset = self.songSettings.getOffset(song)
	}
    func readChantMode() {
        self.chantMode = self.songSettings.getMode()
    }
    func dismiss() {
//        presentationMode.wrappedValue.dismiss()
        self.showSettingsView = false
    }
    func saveAndDismiss() {
        self.modified = true
        self.songSettings.saveOffset()
        dismiss()
    }
    func cancel() {
        if !modified {
            self.songSettings.modifyOffset(song, offset: originalOffset)
        }
    }
    func cancelAndDismiss() {
        self.songSettings.modifyOffset(song, offset: originalOffset)
        dismiss()
    }
}

struct SongSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SongSettingsView(showSettingsView: Binding.constant(true), song: Song.example)
    }
}

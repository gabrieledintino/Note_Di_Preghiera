//
//  SettingsView.swift
//  Canta e Cammina
//
//  Created by Gabriele D'Intino on 11/09/20.
//

import SwiftUI

struct SongSettingsView: View {
	@EnvironmentObject var settings: SongSettings
    @Environment(\.presentationMode) var presentationMode
    @Binding var showSettingsView: Bool
    @State private var selectedOffset = 0
    @State private var originalOffset = 0
    var song: Song
	var offsets = ["0", "0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5"]
    @State private var chantMode = false
    @State private var modified = false
	
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
		
        NavigationView {
            Form {
                Section(header: Text("Toni dei canti")) {
                    Button("Azzera toni") { withAnimation {
                        offset.wrappedValue = 0
                    } }
                    Picker(selection: offset, label: Text("Seleziona di quanto vuoi variare i toni")) {
                        ForEach(0..<offsets.count) {
                            Text(self.offsets[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    Text("Hai selezionato \(offsets[selectedOffset]) toni in più")
                }

                Section(header: Text("Altre impostazioni")) {
                        Toggle("Modalità canto", isOn: bind)
                    }
            }
            .onAppear(perform: { readOffset(song: song); readChantMode() })
            .onDisappear(perform: {
                cancel()
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
		self.selectedOffset = self.settings.getOffset(song)
        self.originalOffset = self.settings.getOffset(song)
	}
    func readChantMode() {
        self.chantMode = self.settings.getMode()
    }
    func dismiss() {
//        presentationMode.wrappedValue.dismiss()
        self.showSettingsView = false
    }
    func saveAndDismiss() {
        modified = true
        self.settings.saveOffset()
        dismiss()
    }
    func cancel() {
        if !modified {
            self.settings.modifyOffset(song, offset: originalOffset)
        }
    }
    func cancelAndDismiss() {
        self.settings.modifyOffset(song, offset: originalOffset)
        dismiss()
    }
}

struct SongSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SongSettingsView(showSettingsView: Binding.constant(true), song: Song.example)
    }
}

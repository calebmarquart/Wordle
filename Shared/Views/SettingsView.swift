//
//  SettingsView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-18.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("What is your favorite color?", selection: $vm.letterCount) {
                        Text("4").tag(4)
                        Text("5").tag(5)
                        Text("6").tag(6)
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Word Length")
                }
                Section {
                    Toggle("Sounds", isOn: $vm.soundEnabled)
                    Toggle("Haptics", isOn: $vm.hapticsEnabled)
                } header: {
                    Text("Preferences")
                }
                Section {
                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("Caleb Marquart").foregroundColor(.gray)
                    }
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("0.1.0").foregroundColor(.gray)
                    }
                } header: {
                    Text("About")
                }

            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(vm: ViewModel())
            .preferredColorScheme(.dark)
    }
}

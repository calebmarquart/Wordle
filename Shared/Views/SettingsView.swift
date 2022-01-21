//
//  SettingsView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-18.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var selections: Int = 5
    let array = [4, 5, 6]
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    Spacer()
                    Text("SETTINGS")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 40)
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .font(.title2)
                        .padding(.trailing)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("HOW LONG OF WORD DO YOU WANT?").font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Spacer()
            }
            .padding(.vertical, 30)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}

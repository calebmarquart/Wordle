//
//  GameView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-20.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var vm: ViewModel
    @State private var showSettings: Bool = false
    @State var showAreYouSure: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                VStack(spacing: 10) {
                    HStack {
                        if vm.isTwoPlayer {
                            Image(systemName: "questionmark.circle")
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.3))
                        } else {
                            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                Image(systemName: "person.2.circle")
                                    .font(.title2)
                                .foregroundColor(.white.opacity(0.3))
                            }
                        }
                            
                        Button(action: {
                            withAnimation(.spring()) { showAreYouSure = true }
                        }) {
                            Image(systemName: "arrow.uturn.backward")
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.3))
                                .padding(.horizontal, 4)
                        }
                        Spacer()
                        Text("WORDLE")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Image(systemName: "text.justify.leading")
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.3))
                                .padding(.horizontal, 4)
                        }
                        Button(action: {
                            showSettings.toggle()
                        }) {
                            Image(systemName: "gear")
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.3))
                        }
                    }
                    .padding()
                    ForEach(vm.collection, id: \.self) { item in
                        WordView(vm: vm, characters: item)
                    }
                    Spacer()
                    
                    //             This is the custom keyboard
                    VStack {
                        ForEach(vm.keyboard, id: \.self) { item in
                            KeyRowView(row: item, vm: vm)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                        .sheet(isPresented: $showSettings) {
                            SettingsView()
                        }
                }
                
                Text("NOT A VALID WORD")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .background(Color("filler"))
                    .cornerRadius(20)
                    .offset(y: vm.showsNotifcation ? 0 : -120)
                
            }
            .blur(radius: vm.showWin || vm.showLoss || showAreYouSure ? 15 : 0)
            
            WinScreenView(vm: vm)
            LoseScreenView(vm: vm)
            AreYouSure(vm: vm, showing: $showAreYouSure, presentation: presentationMode)
            
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(vm: ViewModel())
    }
}

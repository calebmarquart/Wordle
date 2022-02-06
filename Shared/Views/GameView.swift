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
    @State private var showAreYouSure: Bool = false
    @State private var showResetStat: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                VStack(spacing: 10) {
                    HStack {
                        if !vm.isTwoPlayer {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                vm.isDailyMode = false
                            }) {
                                Image(systemName: "person.2.circle")
                                    .font(.title2)
                                    .foregroundColor(.white.opacity(0.3))
                            }
                        }
                        
                        if !vm.isDailyMode {
                            Button(action: {
                                withAnimation(.spring()) { showAreYouSure = true }
                            }) {
                                Image(systemName: "arrow.uturn.backward")
                                    .font(.title2)
                                    .foregroundColor(.white.opacity(0.3))
                                    .padding(.horizontal, 4)
                            }
                        }
                        Spacer()
                        Text("WORDLE")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        if !vm.isTwoPlayer && !vm.isDailyMode {
                            Image(systemName: "text.justify.leading")
                                .font(.title2)
                                .padding(.horizontal, 4)
                                .opacity(0)
                        }
                        
                        if !vm.isTwoPlayer {
                            Button(action: {
                                withAnimation(.spring()) { vm.showStats.toggle() }
                            }) {
                                Image(systemName: "text.justify.leading")
                                    .font(.title2)
                                    .foregroundColor(.white.opacity(0.3))
                                    .padding(.horizontal, 4)
                            }
                        } else {
                            Image(systemName: "text.justify.leading")
                                .font(.title2)
                                .padding(.horizontal, 4)
                                .opacity(0)
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
                            SettingsView(vm: vm)
                        }
                }
                
                Text(vm.message)
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .background(Color("filler"))
                    .cornerRadius(20)
                    .offset(y: vm.showsNotifcation ? 0 : -120)
                
            }
            .opacity(vm.showWin || vm.showLoss || showAreYouSure || vm.showStats ? 0.2 : 1)
            
            WinScreenView(vm: vm)
            LoseScreenView(vm: vm, presentation: presentationMode)
            ConfirmResetGame(vm: vm, showing: $showAreYouSure, presentation: presentationMode)
            StatsView(vm: vm, showStats: $vm.showStats, showReset: $showResetStat)
                .offset(y: -30)
            ConfirmResetStats(vm: vm, showing: $showResetStat)
            
        }
    }
         
    
                            
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(vm: ViewModel())
            .preferredColorScheme(.dark)
    }
}

                             



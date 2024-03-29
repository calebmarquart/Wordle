//
//  PopupView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-18.
//

import SwiftUI

struct WinScreenView: View {
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.spring()) { vm.showWin = false }
                }) {
                    Image(systemName: "xmark").foregroundColor(.gray).font(.title2)
                }
                .padding(.top)
                .padding(.horizontal)
            }
            Text("CONGRATULATIONS!").font(.title).bold()
                .padding(.vertical, 8)
            Text("You got the correct word \(vm.word)\n in \(vm.guessIndex) guess\(vm.guessIndex == 1 ? "" : "es")").font(.title3).multilineTextAlignment(.center)
                .padding(.bottom, 8)
            
            Button(action: {
                withAnimation(.spring()) { vm.showWin = false }
                withAnimation(.spring()) { vm.showStats = true }
            }) {
                Text("NEXT").foregroundColor(.white).bold()
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color("green"))
                    .cornerRadius(8)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color("filler"))
        .cornerRadius(20)
        .padding()
        .offset(y: -70)
        .opacity(vm.showWin ? 1 : 0)
    }
}

struct LoseScreenView: View {
    @ObservedObject var vm: ViewModel
    @Binding var presentation: PresentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.spring()) { vm.showLoss = false }
                }) {
                    Image(systemName: "xmark").foregroundColor(.gray).font(.title2)
                }
                .padding(.top)
                .padding(.horizontal)
            }
            Text("YOU LOST!").font(.title).bold()
                .padding(.vertical, 8)
            Text("The correct word was \(vm.word)").font(.title3).multilineTextAlignment(.center)
                .padding(.bottom)
                
            if !vm.isDailyMode {
                Button(action: {
                    vm.resetGame()
                    if vm.isTwoPlayer {
                        self.$presentation.wrappedValue.dismiss()
                        vm.textField = ""
                    }
                    withAnimation(.spring()) { vm.showLoss = false }
                }) {
                    Text("TRY AGAIN")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .padding(.horizontal)
                        .background(Color("green"))
                        .cornerRadius(10)
                }
                .padding(.bottom, 24)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color("filler"))
        .cornerRadius(20)
        .padding()
        .offset(y: -70)
        .opacity(vm.showLoss ? 1 : 0)
    }
}

struct ConfirmResetGame: View {
    @ObservedObject var vm: ViewModel
    @Binding var showing: Bool
    @Binding var presentation: PresentationMode
    
    var body: some View {
        VStack {
            Text("Are you sure you\n want to reset the game?").font(.title2).bold()
                .padding(.vertical, 8)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation(.spring()) { showing = false }
                }) {
                    Text("NO ")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .padding(.horizontal)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 10, y: 10)
                }
                Button(action: {
                    vm.resetGame()
                    if vm.isTwoPlayer {
                        self.$presentation.wrappedValue.dismiss()
                        vm.textField = ""
                    }
                    withAnimation(.spring()) { showing = false }
                }) {
                    Text("YES")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .padding(.horizontal)
                        .background(Color("green"))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 10, y: 10)
                }
            }
            .padding(8)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color("filler"))
        .cornerRadius(20)
        .padding()
        .offset(y: -70)
        .opacity(showing ? 1 : 0)
    }
}

struct ConfirmResetStats: View {
    @ObservedObject var vm: ViewModel
    @Binding var showing: Bool
    
    var body: some View {
        VStack {
            Text("Are you sure you\n want to reset statistics?").font(.title2).bold()
                .padding(.vertical, 8)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation(.spring()) { showing = false }
                }) {
                    Text("NO ")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .padding(.horizontal)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 10, y: 10)
                }
                Button(action: {
                    vm.resetStatistics()
                    withAnimation(.spring()) { showing = false }
                }) {
                    Text("YES")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .padding(.horizontal)
                        .background(Color("green"))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 10, y: 10)
                }
            }
            .padding(8)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color("filler"))
        .cornerRadius(20)
        .padding()
        .offset(y: -70)
        .opacity(showing ? 1 : 0)
    }
}

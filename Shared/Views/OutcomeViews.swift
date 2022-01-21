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
            Text("You got the correct word \(vm.word)\n in \(vm.guessIndex) guesses ").font(.title3).multilineTextAlignment(.center)
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity)
        .background(Color("filler").blur(radius: 5))
        .cornerRadius(20)
        .padding()
        .offset(y: -70)
        .opacity(vm.showWin ? 1 : 0)
    }
}

struct LoseScreenView: View {
    @ObservedObject var vm: ViewModel
    
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
                
            Button(action: {
                withAnimation(.spring()) { vm.showLoss = false }
                vm.resetGame()
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
        .frame(maxWidth: .infinity)
        .background(Color("filler").blur(radius: 5))
        .cornerRadius(20)
        .padding()
        .offset(y: -70)
        .opacity(vm.showLoss ? 1 : 0)
    }
}


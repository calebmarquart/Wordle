//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Marquart on 2022-01-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.3))
                        Button(action: {
                            vm.resetGame()
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
                        Image(systemName: "gear")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.3))
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
            .blur(radius: vm.showWin ? 10 : 0)
            
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}













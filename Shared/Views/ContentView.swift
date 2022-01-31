//
//  ContentView.swift
//  Shared
//
//  Created by Caleb Marquart on 2022-01-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    @State var singlePlayerActive: Bool = false
    @State var twoPlayerActive: Bool = false
    @State var showSettings: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("WORDLE  2")
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
                .padding(.leading, 8)
                
                VStack(spacing: 50) {
                    Button(action: {
                        vm.isDailyMode = true
                        vm.isTwoPlayer = false
                        vm.resetGame()
                        vm.word = realWordleSet[vm.getDateIndex()+196].uppercased()
                        var solutionArr = [Character]()
                        for char in vm.word {
                            solutionArr.append(char)
                        }
                        vm.solutionArr = solutionArr
                        vm.letterCount = 5
                        singlePlayerActive = true
                    }) {
                        VStack {
                            Image(systemName: "calendar").font(.system(size: 50))
                            Text("Daily").bold()
                                .padding(4)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("green"))
                        .cornerRadius(20)
                    }
                    
                    Button(action: {
                        singlePlayerActive = true
                        vm.isTwoPlayer = false
                        vm.resetGame()
                    }) {
                        VStack {
                            Image(systemName: "person.fill").font(.system(size: 50))
                            Text("One Player").bold()
                                .padding(4)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .background(Color("yellow"))
                        .cornerRadius(20)
                    }
                    
                    Button(action: {
                        twoPlayerActive = true
                        vm.isTwoPlayer = true
                    }) {
                        VStack {
                            Image(systemName: "person.2.fill").font(.system(size: 50))
                            Text("Two Player").bold()
                                .padding(4)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .background(Color("filler"))
                        .cornerRadius(20)
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 150, alignment: .center)
                .padding()
                
                NavigationLink(destination:
                                GameView(vm: vm)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                               , isActive: $singlePlayerActive) { EmptyView() }
                
                Spacer()
                
                VStack(spacing: 5) {
                    Text("Adapted by Caleb Marquart").bold()
                    Link("Inspired by WORDLE", destination: URL(string: "https://www.powerlanguage.co.uk/wordle")!).foregroundColor(Color.gray)
                }
                .padding()
                .padding(.vertical, 30)
                
                
                
                NavigationLink(destination: TypeWordView(vm: vm).navigationTitle("Two Player").navigationBarTitleDisplayMode(.inline), isActive: $twoPlayerActive){ EmptyView() }
                .sheet(isPresented: $showSettings) {
                    SettingsView(vm: vm)
                }

            }
            .navigationTitle("")
            .navigationBarHidden(true)
                
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}




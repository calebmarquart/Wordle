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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Button(action: {
                    singlePlayerActive = true
                    vm.isTwoPlayer = false
                }) {
                    VStack {
                        Image(systemName: "person.fill").font(.system(size: 80))
                        Text("One Player").bold()
                            .padding(4)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("yellow"))
                    .cornerRadius(20)
                }
                NavigationLink(destination:
                                GameView(vm: vm)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                               , isActive: $singlePlayerActive) { EmptyView() }
                
                Button(action: {
                    twoPlayerActive = true
                    vm.isTwoPlayer = true
                }) {
                    VStack {
                        Image(systemName: "person.2.fill").font(.system(size: 80))
                        Text("Two Player").bold()
                            .padding(4)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("yellow"))
                .cornerRadius(20)
                }
                
                NavigationLink(destination: TypeWordView(vm: vm).navigationTitle("Two Player").navigationBarTitleDisplayMode(.inline), isActive: $twoPlayerActive){ EmptyView() }
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




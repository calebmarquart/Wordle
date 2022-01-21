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
        NavigationView {
            VStack(spacing: 50) {
                NavigationLink(destination:
                                GameView(vm: vm)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                ) {
                    VStack {
                        Image(systemName: "person.fill").font(.system(size: 80))
                        Text("ONE PLAYER").bold()
                            .padding(4)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("yellow"))
                    .cornerRadius(20)
                }
                
                NavigationLink(destination: TypeWordView(vm: vm)) {
                    VStack {
                        Image(systemName: "person.2.fill").font(.system(size: 80))
                        Text("TWO PLAYER").bold()
                            .padding(4)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("yellow"))
                .cornerRadius(20)
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




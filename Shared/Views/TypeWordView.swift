//
//  TypeWordView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-20.
//

import SwiftUI

struct TypeWordView: View {
    @ObservedObject var vm: ViewModel
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Enter a word for your opponent to guess")
                HStack {
                    TextField("\(vm.letterCount) letter word", text: $vm.textField)
                        .padding()
                        .background(Color("filler"))
                        .cornerRadius(10)
                    
                    Button(action: {
                        isActive = vm.twoPlayerWordTyped()
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                            .background(Color("green"))
                            .cornerRadius(10)
                    }
                    
                }
                .padding(.horizontal)
                
            }
            .offset(y: -80)
            
            NavigationLink(destination:
                            GameView(vm: vm)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)                           , isActive: $isActive) {EmptyView()}
            
        }
    }
}

struct TypeWordView_Previews: PreviewProvider {
    static var previews: some View {
        TypeWordView(vm: ViewModel())
            .preferredColorScheme(.dark)
    }
}

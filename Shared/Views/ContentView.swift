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
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "questionmark.circle")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.3))
                Image(systemName: "arrow.uturn.backward")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 4)
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
                WordView(characters: item)
            }
            Spacer()
            
//             This is the custom keyboard
            VStack {
                ForEach(keyboard, id: \.self) { item in
                    KeyRowView(row: item, vm: vm)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}













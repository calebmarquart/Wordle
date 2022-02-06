//
//  KeyView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-17.
//

import SwiftUI

struct KeyView: View {
    @ObservedObject var vm: ViewModel
    @State var color: Color = .gray
    var letter: Character
    var state: Status
    
    var body: some View {
        Button(action: {
            vm.keyPressed(letter)
        }) {
            ZStack {
                color
                    .onAppear {
                        switch state {
                        case .correct: withAnimation(.easeInOut) { color = Color("green") }
                        case .contains: withAnimation(.easeInOut) { color = Color("yellow") }
                        case .none: withAnimation(.easeInOut) { color = Color("keys") }
                        default: withAnimation(.easeInOut) { color = .gray }
                        }
                    }
                
                Text(String(letter))
                    .foregroundColor(.white)
                    .bold()
            }
            .frame(width: 30, height: 60)
            .background(Color.gray)
            .cornerRadius(6)
        }
    }
}

struct KeyRowView: View {
    var row: [CharacterData]
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        HStack(spacing: 6) {
            if row.count == 7 {
                Button(action: vm.guess) {
                    ZStack {
                        Color.gray
                        Text("ENTER")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(width: 60, height: 60)
                    .background(Color.gray)
                .cornerRadius(6)
                }
            }
            ForEach(row, id: \.self) { item in
                KeyView(vm: vm, letter: item.char!, state: item.state)
            }
            if row.count == 7 {
                Button(action: vm.delete) {
                    ZStack {
                        Color.gray
                        Image(systemName: "delete.left")
                            .foregroundColor(.white)
                    }
                    .frame(width: 40, height: 60)
                    .background(Color.gray)
                    .cornerRadius(6)
                }
            }
        }
    }
}

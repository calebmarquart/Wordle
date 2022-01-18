//
//  KeyView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-17.
//

import SwiftUI

struct KeyView: View {
    @ObservedObject var vm: ViewModel
    var letter: Character
    
    var body: some View {
        Button(action: {
            vm.keyPressed(letter)
        }) {
            ZStack {
                Color.gray
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
                KeyView(vm: vm, letter: item.char!)
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

let keyboard: [[CharacterData]] = [
    [CharacterData(char: "Q", state: .empty),
    CharacterData(char: "W", state: .empty),
    CharacterData(char: "E", state: .empty),
    CharacterData(char: "R", state: .empty),
    CharacterData(char: "T", state: .empty),
    CharacterData(char: "Y", state: .empty),
    CharacterData(char: "U", state: .empty),
    CharacterData(char: "I", state: .empty),
    CharacterData(char: "O", state: .empty),
    CharacterData(char: "P", state: .empty)],
    
    [CharacterData(char: "A", state: .empty),
    CharacterData(char: "S", state: .empty),
    CharacterData(char: "D", state: .empty),
    CharacterData(char: "F", state: .empty),
    CharacterData(char: "G", state: .empty),
    CharacterData(char: "H", state: .empty),
    CharacterData(char: "J", state: .empty),
    CharacterData(char: "K", state: .empty),
    CharacterData(char: "L", state: .empty)],
    
    [CharacterData(char: "Z", state: .empty),
    CharacterData(char: "X", state: .empty),
    CharacterData(char: "C", state: .empty),
    CharacterData(char: "V", state: .empty),
    CharacterData(char: "B", state: .empty),
    CharacterData(char: "N", state: .empty),
    CharacterData(char: "M", state: .empty)],

]

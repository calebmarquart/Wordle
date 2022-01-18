//
//  WordView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-17.
//

import SwiftUI

struct WordView: View {
    var characters: [CharacterData]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(characters, id: \.id) { item in
                Letter(letter: item.char, state: item.state)
            }
        }
    }
}

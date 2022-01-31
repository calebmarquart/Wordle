//
//  Model.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-16.
//

import Foundation

enum Status {
    case none
    case empty
    case contains
    case correct
}

struct CharacterData: Identifiable, Hashable {
    var id = UUID()
    var char: Character?
    var state: Status = .empty
}

let notInList = "NOT IN WORD LIST"
let tooShort = "NOT ENOUGH LETTERS"

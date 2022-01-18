//
//  ViewModel.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-16.
//

import SwiftUI

class ViewModel: ObservableObject {
    var word: String = ""
    var charArr = [Character]()
    
    @Published var guessIndex: Int = 0
    @Published var currentWordIndex: Int = 0
    @Published var allowedToAnimate: Bool = false
    
    @Published var collection: [[CharacterData]] = [
        [CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),],
        
        [CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),],
        
        [CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),],
        
        [CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),],
        
        [CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),],
        
        [CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),
         CharacterData(char: nil),]
    ]
    
    init() {
        word = (words5.randomElement()?.lowercased())!
        print(word)
        for char in word {
            charArr.append(char)
        }
    }
    
    func guess() {
        print("A guess was attemped")
        let arr = collection[guessIndex]
        guard arr.last?.char != nil else { print("nil found in last letter of guess \(guessIndex + 1)"); return }
        var newArr = [Character]()
        for arr in arr {
            newArr.append(arr.char!)
        }
        let word = String(newArr).lowercased()
        print(newArr, word)
        
        guard word.count == 5 else { print("word too short"); return }
        guard word.isCorrect() else { print("not a real word"); return }
        guard guessIndex < 6 else { print("you lose"); return }
        
        var guessArr = [Character]()
        for char in word {
            guessArr.append(char)
        }
        
        allowedToAnimate = true
        
        for i in 0 ..< guessArr.count {
            if guessArr[i] == charArr[i] {
                collection[guessIndex][i].state = .correct
            } else if charArr.contains(guessArr[i]) {
                collection[guessIndex][i].state = .contains
            } else {
                collection[guessIndex][i].state = .none
            }
        }
        guessIndex += 1
        currentWordIndex = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allowedToAnimate = false
        }
        
    }
    
    func keyPressed(_ letter: Character) {
        guard currentWordIndex < 5 else { return }
        collection[guessIndex][currentWordIndex] = CharacterData(char: letter, state: .none)
        currentWordIndex += 1
    }
    
    func delete() {
        guard currentWordIndex > 0 else { return }
        currentWordIndex -= 1
        collection[guessIndex][currentWordIndex] = CharacterData(char: nil, state: .empty)
    }
    
    
}

//
//  ViewModel.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-16.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var word: String = ""
    @Published var charArr = [Character]()
    
    @Published var guessIndex: Int = 0
    @Published var currentWordIndex: Int = 0
    @Published var showsNotifcation: Bool = false
    @Published var shake: Bool = false
    @Published var showWin: Bool = false
    @Published var showLoss: Bool = false
    @Published var isTwoPlayer: Bool = false
    
    @Published var greenLetters = Set<Character>()
    @Published var noneLetters = Set<Character>()
    @Published var yellowLetters = Set<Character>()
    
    @Published var collection = [[CharacterData]]()
    
    @Published var keyboard: [[CharacterData]] = [
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
         CharacterData(char: "M", state: .empty)]
    ]
    
    init() {
        word = (words5.randomElement()?.uppercased())!
        print(word)
        for char in word {
            charArr.append(char)
        }
        var collection = [[CharacterData]]()
        for _ in 0..<6 {
            var length = [CharacterData]()
            for _ in 0..<5 {
                length.append(CharacterData(char: nil))
            }
            collection.append(length)
        }
        self.collection = collection
    }
    
    func guess() {
        guard guessIndex < 6 else { print("you lose"); return }
        let arr = collection[guessIndex]
        guard arr.last?.char != nil else { print("nil found in last letter of guess \(guessIndex + 1)"); return }
        var newArr = [Character]()
        for arr in arr {
            newArr.append(arr.char!)
        }
        let word = String(newArr).uppercased()
        print("You guessed the word \(word)")
        
        guard word.count == 5 else { print("word too short"); return }
        guard word.isCorrect() else { print("not a real word"); notAWord(); return }
        
        var guessArr = [Character]()
        for char in word {
            guessArr.append(char)
        }
        
        var saveIndex = Set<Character>()
        for i in 0 ..< guessArr.count {
            if guessArr[i] == charArr[i] {
                collection[guessIndex][i].state = .correct
                greenLetters.insert(guessArr[i])
                saveIndex.insert(guessArr[i])
            } else if charArr.contains(guessArr[i]) && !saveIndex.contains(guessArr[i]) {
                collection[guessIndex][i].state = .contains
                yellowLetters.insert(guessArr[i])
            } else {
                collection[guessIndex][i].state = .none
                noneLetters.insert(guessArr[i])
            }
        }
        guessIndex += 1
        currentWordIndex = 0
        updateKeys()
        greenLetters = Set<Character>()
        noneLetters = Set<Character>()
        yellowLetters = Set<Character>()
        if word == self.word {
            HapticsManager.instance.notification(.success)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring()) { self.showWin = true }
            }
        } else if guessIndex > 5 {
            HapticsManager.instance.notification(.error)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring()) { self.showLoss = true }
            }
        }
    }
    
    func keyPressed(_ letter: Character) {
        guard currentWordIndex < 5 else { return }
        collection[guessIndex][currentWordIndex] = CharacterData(char: letter)
        currentWordIndex += 1
    }
    
    func delete() {
        guard currentWordIndex > 0 else { return }
        currentWordIndex -= 1
        collection[guessIndex][currentWordIndex] = CharacterData(char: nil)
    }
    
    func notAWord() {
        withAnimation(.easeInOut) { shake.toggle() }
        withAnimation(.spring()) { showsNotifcation = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.spring()) { self.showsNotifcation = false }
        }
        HapticsManager.instance.notification(.warning)
    }
    
    func resetGame() {
        keyboard = [
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
             CharacterData(char: "M", state: .empty)]
        ]
        
        collection = [
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
        
        guessIndex = 0
        currentWordIndex = 0
        
        word = (words5.randomElement()?.uppercased())!
        charArr = []
        print(word)
        for char in word {
            charArr.append(char)
        }
        
    }
    
    func updateKeys() {
        for char in noneLetters {
            var firstIndex: Int = -1
            switch char {
            case "Q","W", "E", "R", "T", "Y", "U", "I", "O", "P": firstIndex = 0
            case "A", "S", "D", "F", "G", "H", "J", "K", "L": firstIndex = 1
            case "Z", "X", "C", "V", "B", "N", "M": firstIndex = 2
            default: break
            }
            if let secondIndex = keyboard[firstIndex].firstIndex(where: {$0.char == char}) {
                keyboard[firstIndex][secondIndex].state = .none
            }
        }
        
        for char in yellowLetters {
            var firstIndex: Int = -1
            switch char {
            case "Q","W", "E", "R", "T", "Y", "U", "I", "O", "P": firstIndex = 0
            case "A", "S", "D", "F", "G", "H", "J", "K", "L": firstIndex = 1
            case "Z", "X", "C", "V", "B", "N", "M": firstIndex = 2
            default: break
            }
            if let secondIndex = keyboard[firstIndex].firstIndex(where: {$0.char == char}) {
                keyboard[firstIndex][secondIndex].state = .contains
            }
        }
        
        for char in greenLetters {
            var firstIndex: Int = -1
            switch char {
            case "Q","W", "E", "R", "T", "Y", "U", "I", "O", "P": firstIndex = 0
            case "A", "S", "D", "F", "G", "H", "J", "K", "L": firstIndex = 1
            case "Z", "X", "C", "V", "B", "N", "M": firstIndex = 2
            default: break
            }
            if let secondIndex = keyboard[firstIndex].firstIndex(where: {$0.char == char}) {
                keyboard[firstIndex][secondIndex].state = .correct
            }
        }
    }
    
    
}

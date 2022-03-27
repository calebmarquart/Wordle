//
//  ViewModel.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-16.
//

import SwiftUI
import CoreData

class ViewModel: ObservableObject {
    @AppStorage("letterCount") var letterCount: Int = 5 { didSet { resetGame() }}
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("hapticsEnabled") var hapticsEnabled: Bool = true

    var gameCompleted = false
    @Published var word: String = ""
    @Published var solutionArr = [Character]()
    @Published var winPercentage: Int = 0
    @Published var activeStat: StatObject = StatObject(gamesPlayed: 0, gamesWon: 0, currentStreak: 0, maxStreak: 0, distribution: [0, 0, 0, 0, 0, 0]) { didSet {
        winPercentage = winPercentage(a: activeStat.gamesWon, b: activeStat.gamesPlayed)
        if (activeStat.distribution.max() ?? 1) > 0 {
            maxGuess = activeStat.distribution.max() ?? 1
        } else {
            maxGuess = 1
        }
    }}
    @Published var highlightedDistribution: Int = -1
    @Published var maxGuess: Int = 1
    @Published var textField: String = ""
    @Published var guessIndex: Int = 0
    @Published var letterIndex: Int = 0
    @Published var showsNotifcation: Bool = false
    @Published var message: String = ""
    @Published var shake: Bool = false
    @Published var showWin: Bool = false
    @Published var showLoss: Bool = false
    @Published var showStats: Bool = false
    @Published var isTwoPlayer: Bool = false
    @Published var isDailyMode: Bool = false
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
        collection = createEmptyBoard(rows: 6, rowLength: letterCount)
    }
    
    func guess() {
        guard guessIndex < 6 else { print("you lose"); return }
        let arr = collection[guessIndex]
        guard arr.last?.char != nil else { showNotification(message: tooShort); return }
        var newArr = [Character]()
        for arr in arr {
            newArr.append(arr.char!)
        }
        let word = String(newArr).uppercased()
        print("You guessed the word \(word)")
        if guessIndex == 0 && !isTwoPlayer {
            activeStat.gamesPlayed += 1
            if isDailyMode {
                StatsHelper().saveDailyStat(activeStat)
            } else {
                StatsHelper().saveSingleStat(activeStat)
            }
        }
        
        guard word.isCorrect() else { print("NOT A REAL WORD"); showNotification(message: notInList); return }
        
        var guessArr = [Character]()
        for char in word {
            guessArr.append(char)
        }
        
        var numOfOccurencesForEachLetter = [Character: Int]()
        
        for i in guessArr.indices {
            let guessedChar = guessArr[i]
            let numOfOccurences: Int = {
                var n = 0
                for char in solutionArr {
                    if guessedChar == char {
                        n += 1
                    }
                }
                return n
            }()
            if numOfOccurencesForEachLetter[guessedChar] == nil {
                numOfOccurencesForEachLetter[guessedChar] = numOfOccurences
            }
        }
        
        for i in guessArr.indices {
            let guessedChar = guessArr[i]
            let solutionChar = solutionArr[i]
            
            if guessedChar == solutionChar {
                collection[guessIndex][i].state = .correct
                numOfOccurencesForEachLetter[guessedChar]! -= 1
            }
        }
        
        for i in guessArr.indices {
            let guessedChar = guessArr[i]
            if !(guessedChar == solutionArr[i]) && numOfOccurencesForEachLetter[guessedChar]! > 0 {
                collection[guessIndex][i].state = .contains
                numOfOccurencesForEachLetter[guessedChar]! -= 1
                yellowLetters.insert(guessedChar)
            } else {
                collection[guessIndex][i].state = .none
                noneLetters.insert(guessedChar)
            }
        }
        
        for i in guessArr.indices {
            if guessArr[i] == solutionArr[i] {
                collection[guessIndex][i].state = .correct
                greenLetters.insert(guessArr[i])
            }
        }
        
        guessIndex += 1
        letterIndex = 0
        updateKeys()
        
        if word == self.word {
            triggerWin()
        } else if guessIndex > 5 {
            triggerLoss()
        }
    }
    
    func triggerWin() {
        if !isTwoPlayer {
            gameCompleted = true
            activeStat.currentStreak += 1
            activeStat.gamesWon += 1
            if activeStat.maxStreak < activeStat.currentStreak {
                activeStat.maxStreak = activeStat.currentStreak
            }
            activeStat.distribution[guessIndex-1] += 1
            
            if isDailyMode {
                highlightedDistribution = guessIndex-1
                StatsHelper().saveDailyStat(activeStat)
            } else {
                StatsHelper().saveSingleStat(activeStat)
            }
        }
        
        if hapticsEnabled { HapticsManager.instance.notification(.success) }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.spring()) { self.showWin = true }
            if self.soundEnabled { SoundMangaer.instance.playSound(winSound) }
        }
    }
    
    func triggerLoss() {
        gameCompleted = true
        if !isTwoPlayer {
            if activeStat.maxStreak < activeStat.currentStreak {
                activeStat.maxStreak = activeStat.currentStreak
            }
            activeStat.currentStreak = 0
            
            if isDailyMode {
                StatsHelper().saveDailyStat(activeStat)
            } else {
                StatsHelper().saveSingleStat(activeStat)
            }
        }
        if hapticsEnabled { HapticsManager.instance.notification(.error) }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.spring()) { self.showLoss = true }
            if self.soundEnabled { SoundMangaer.instance.playSound(lossSound) }
        }
    }
    
    func keyPressed(_ letter: Character) {
        guard letterIndex < letterCount && !gameCompleted else { return }
        collection[guessIndex][letterIndex] = CharacterData(char: letter)
        letterIndex += 1
    }
    
    func delete() {
        guard letterIndex > 0 && !gameCompleted else { return }
        letterIndex -= 1
        collection[guessIndex][letterIndex] = CharacterData(char: nil)
    }
    
    func showNotification(message: String) {
        self.message = message
        withAnimation(.easeInOut) { shake.toggle() }
        withAnimation(.spring()) { showsNotifcation = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.spring()) { self.showsNotifcation = false }
        }
        if hapticsEnabled { HapticsManager.instance.notification(.warning) }
    }
    
    func changeRandomWord() {
        switch letterCount {
        case 4: word = (words4.randomElement()?.uppercased())!
        case 6: word = (words6.randomElement()?.uppercased())!
        default: word = (words5.randomElement()?.uppercased())!
        }
        print(word)
        var solutionArr = [Character]()
        for char in word {
            solutionArr.append(char)
        }
        self.solutionArr = solutionArr
    }
    
    func resetStatistics() {
        activeStat = StatObject(gamesPlayed: 0, gamesWon: 0, currentStreak: 0, maxStreak: 0, distribution: [0, 0, 0, 0, 0, 0])
        highlightedDistribution = -1
        
        if isDailyMode {
            StatsHelper().saveDailyStat(activeStat)
        } else {
            StatsHelper().saveSingleStat(activeStat)
        }
        
    }
    
    func resetGame() {
        for row in 0..<keyboard.count {
            for letter in 0..<keyboard[row].count {
                keyboard[row][letter].state = .empty
            }
        }
        
        collection = createEmptyBoard(rows: 6, rowLength: letterCount)
        
        guessIndex = 0
        letterIndex = 0
        gameCompleted = false
        highlightedDistribution = -1
        
        if !isTwoPlayer && !isDailyMode {
            changeRandomWord()
        }
    }
    
    func winPercentage(a: Int, b: Int) -> Int {
        if b == 0 {
            return 0
        } else {
            return Int((Double(a)/Double(b) * 100))
        }
    }
    
    func getDateIndex() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let referenceDate = formatter.date(from: "2022/01/01")
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: referenceDate!)
        let date2 = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
    
    func createEmptyBoard(rows: Int, rowLength: Int) -> [[CharacterData]] {
        var collection = [[CharacterData]]()
        for _ in 0..<rows {
            var row = [CharacterData]()
            for _ in 0..<rowLength {
                row.append(CharacterData(char: nil))
            }
            collection.append(row)
        }
        return collection
    }
    
    func twoPlayerWordTyped() -> Bool {
        guard textField.isCorrect() else { return false }
        var newArr = [Character]()
        for char in textField.uppercased() {
            newArr.append(char)
        }
        guard newArr.count == letterCount else { return false }
        word = textField.uppercased()
        solutionArr = newArr
        return true
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
        
        // Makes character sets empty after each guess
        greenLetters = Set<Character>()
        noneLetters = Set<Character>()
        yellowLetters = Set<Character>()
    }
}


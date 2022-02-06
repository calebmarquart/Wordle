//
//  StatsHelper.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-30.
//

import SwiftUI

class StatsHelper {
    
    // Save Functions
    func saveSingleStat(_ object: StatObject) {
        let defaults = UserDefaults.standard
        defaults.set(object.gamesPlayed, forKey: "singleGamesPlayed")
        defaults.set(object.gamesWon, forKey: "singleGamesWon")
        defaults.set(object.currentStreak, forKey: "singleCurrentStreak")
        defaults.set(object.maxStreak, forKey: "singleMaxStreak")
        defaults.set(object.distribution, forKey: "singleDistribution")
    }
    func saveDailyStat(_ object: StatObject) {
        let defaults = UserDefaults.standard
        defaults.set(object.gamesPlayed, forKey: "dailyGamesPlayed")
        defaults.set(object.gamesWon, forKey: "dailyGamesWon")
        defaults.set(object.currentStreak, forKey: "dailyCurrentStreak")
        defaults.set(object.maxStreak, forKey: "dailyMaxStreak")
        defaults.set(object.distribution, forKey: "dailyDistribution")
    }
    
    // Fetch Functions
    func fetchSingleStat() -> StatObject {
        let defaults = UserDefaults.standard
        let gamesPlayed = defaults.object(forKey: "singleGamesPlayed") as? Int ?? 0
        let gamesWon = defaults.object(forKey: "singleGamesWon") as? Int ?? 0
        let currentStreak = defaults.object(forKey: "singleCurrentStreak") as? Int ?? 0
        let maxStreak = defaults.object(forKey: "singleMaxStreak") as? Int ?? 0
        let distribution = defaults.object(forKey: "singleDistribution") as? [Int] ?? [0, 0, 0, 0, 0, 0]
        return StatObject(gamesPlayed: gamesPlayed, gamesWon: gamesWon, currentStreak: currentStreak, maxStreak: maxStreak, distribution: distribution)
    }
    func fetchDailyStat() -> StatObject {
        let defaults = UserDefaults.standard
        let gamesPlayed = defaults.object(forKey: "dailyGamesPlayed") as? Int ?? 0
        let gamesWon = defaults.object(forKey: "dailyGamesWon") as? Int ?? 0
        let currentStreak = defaults.object(forKey: "dailyCurrentStreak") as? Int ?? 0
        let maxStreak = defaults.object(forKey: "dailyMaxStreak") as? Int ?? 0
        let distribution = defaults.object(forKey: "dailyDistribution") as? [Int] ?? [0, 0, 0, 0, 0, 0]
        return StatObject(gamesPlayed: gamesPlayed, gamesWon: gamesWon, currentStreak: currentStreak, maxStreak: maxStreak, distribution: distribution)
    }
    
}

struct StatObject {
    var gamesPlayed: Int
    var gamesWon: Int
    var currentStreak: Int
    var maxStreak: Int
    var distribution: [Int]
}

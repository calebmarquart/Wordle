//
//  StatsHelper.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-30.
//

import SwiftUI

class StatsHelper {
    
    // Save Functions
    func saveSingleStat(gamesPlayed: Int, gamesWon: Int, currentStreak: Int, maxStreak: Int, distribution: [Int]) {
        let defaults = UserDefaults.standard
        defaults.set(gamesPlayed, forKey: "singleGamesPlayed")
        defaults.set(gamesWon, forKey: "singleGamesWon")
        defaults.set(currentStreak, forKey: "singleCurrentStreak")
        defaults.set(maxStreak, forKey: "singleMaxStreak")
        defaults.set(distribution, forKey: "singleDistribution")
    }
    func saveDailyStat(gamesPlayed: Int, gamesWon: Int, currentStreak: Int, maxStreak: Int, distribution: [Int]) {
        let defaults = UserDefaults.standard
        defaults.set(gamesPlayed, forKey: "dailyGamesPlayed")
        defaults.set(gamesWon, forKey: "dailyGamesWon")
        defaults.set(currentStreak, forKey: "dailyCurrentStreak")
        defaults.set(maxStreak, forKey: "dailyMaxStreak")
        defaults.set(distribution, forKey: "dailyDistribution")
    }
    
    // Fetch Functions
    func fetchSingleStat() -> StatObject {
        let defaults = UserDefaults.standard
        let gamesPlayed = defaults.object(forKey: "singleGamesPlayed") as? Int ?? 0
        let gamesWon = defaults.object(forKey: "singleGamesWon") as? Int ?? 0
        let currentStreak = defaults.object(forKey: "singleCurrentStreak") as? Int ?? 0
        let maxStreak = defaults.object(forKey: "singleMaxStreak") as? Int ?? 0
        let distribution = defaults.object(forKey: "singleDistribution") as? [Int] ?? [0, 0, 0, 0, 0, 0]
        return StatObject(gamesPlayed: gamesPlayed, gamesWon: gamesWon, currentStreak: currentStreak, maxStreak: maxStreak, distrubution: distribution)
    }
    func fetchDailyStat() -> StatObject {
        let defaults = UserDefaults.standard
        let gamesPlayed = defaults.object(forKey: "dailyGamesPlayed") as? Int ?? 0
        let gamesWon = defaults.object(forKey: "dailyGamesWon") as? Int ?? 0
        let currentStreak = defaults.object(forKey: "dailyCurrentStreak") as? Int ?? 0
        let maxStreak = defaults.object(forKey: "dailyMaxStreak") as? Int ?? 0
        let distribution = defaults.object(forKey: "dailyDistribution") as? [Int] ?? [0, 0, 0, 0, 0, 0]
        return StatObject(gamesPlayed: gamesPlayed, gamesWon: gamesWon, currentStreak: currentStreak, maxStreak: maxStreak, distrubution: distribution)
    }
    
}

struct StatObject {
    let gamesPlayed: Int
    let gamesWon: Int
    let currentStreak: Int
    let maxStreak: Int
    let distrubution: [Int]
}

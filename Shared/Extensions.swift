//
//  Extensions.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-17.
//

import SwiftUI

extension String {
    func isCorrect() -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: self.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
}

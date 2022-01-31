//
//  Extensions.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-17.
//

import SwiftUI

extension String {
    func isCorrect() -> Bool {
        guard !bannedWords.contains(self.lowercased()) else { return false }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: self.lowercased().utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: self.lowercased(), range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
} 

struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat
    
    func modifier(_ x: CGFloat) -> CGFloat {
        10 * sin(x * .pi * 2)
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let transform = ProjectionTransform(CGAffineTransform(translationX: modifier(animatableData), y: 0))
        
        return transform
    }
    
}

class HapticsManager {
    static let instance = HapticsManager()
    
    func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

//
//  LetterView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-17.
//

import SwiftUI

struct Letter: View {
    @State var color: Color = .black
    var letter: Character?
    var state: Status
    
    var body: some View {
        ZStack {
            Rectangle().fill(color)
                .onChange(of: state) { state in
                    switch state {
                    case .correct: color = .green
                    case .contains: color = .yellow
                    case .none: color = .gray.opacity(0.2)
                    default: color = .black
                    }
                }
            if letter != nil {
                Text(String(letter!).uppercased())
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 3, y: 3)
            }
        }
        .frame(width: 55, height: 55)
        .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                )
    }
}

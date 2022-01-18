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
                .animation(.easeInOut, value: color)
                .onAppear {
                    switch state {
                    case .correct: color = Color("green")
                    case .contains: color = Color("yellow")
                    case .none: color = Color("filler")
                    default: color = .black
                    }
                }
            if letter != nil {
                Text(String(letter!).uppercased())
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .frame(width: 55, height: 55)
        .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white.opacity(letter != nil ? 0.3 : 0.2), lineWidth: state == .empty ? 2 : 0)
                )
    }
}

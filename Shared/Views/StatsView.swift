//
//  StatsView.swift
//  Wordle
//
//  Created by Caleb Marquart on 2022-01-28.
//

import SwiftUI

struct StatsView: View {
    @ObservedObject var vm: ViewModel
    @Binding var showStats: Bool
    @Binding var showReset: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.spring()) { showStats.toggle() }
                }) {
                    Image(systemName: "xmark").foregroundColor(.white).opacity(0.3)
                }
            }
            Text("STATISTICS").font(.title2).bold()
            Text(vm.isDailyMode ? "Daily" : "Single Player").foregroundColor(.gray)
            
            HStack(alignment: .top, spacing: 20) {
                VStack {
                    Text(String(vm.activeStat.gamesPlayed)).font(.title).bold()
                    Text("Played")
                }
                VStack {
                    Text(String(vm.winPercentage)).font(.title).bold()
                    Text("Win %").multilineTextAlignment(.center)
                }
                VStack {
                    Text(String(vm.activeStat.currentStreak)).font(.title).bold()
                    Text("Current\nStreak").multilineTextAlignment(.center)
                }
                VStack {
                    Text(String(vm.activeStat.maxStreak)).font(.title).bold()
                    Text("Max\nStreak").multilineTextAlignment(.center)
                }
            }
            .padding(8)
            Text("GUESS DISTRIBUTION").font(.title3).bold().padding(.top, 8)
            
            VStack(alignment: .leading) {
                ForEach(0 ..< 6) { i in
                    HStack {
                        Text(String(i+1))
                        GeometryReader { geometry in
                            ZStack {
                                i == vm.highlightedDistribution ? Color("green") : Color.gray
                                Text(String(vm.activeStat.distribution[i])).bold().frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 8)
                            }
                            .frame(width: (geometry.size.width * (Double(vm.activeStat.distribution[i])/Double(vm.maxGuess))) < 30 ? 30 : (geometry.size.width * (Double(vm.activeStat.distribution[i])/Double(vm.maxGuess)))
                            )
                            
                        }
                        .frame(height: 24)
                    }
                }
            }
            .padding(.vertical, 8)
            
            Button(action: {
                withAnimation(.spring()) { showReset = true }
            }) {
                Text("RESET STATS")
                    .foregroundColor(.white)
                    .bold()
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(Color("green"))
                    .cornerRadius(8)
            }
            .padding()
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 60)
        .background(Color("filler"))
        .cornerRadius(10)
        .opacity(showStats ? 1 : 0)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(vm: ViewModel(), showStats: .constant(true), showReset: .constant(false))
            .preferredColorScheme(.dark)
    }
}

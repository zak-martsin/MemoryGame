//
//  File.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import Foundation
import Combine

class ViewModel: ObservableObject{
     let currentTheme: Theme<String>
    @Published var model: MemoryGameModel<String>

    private static func createGame (from theme: Theme<String>) -> MemoryGameModel<String> {
        return MemoryGameModel(numberOfPairs: theme.numberOfPairs) { pairIndex in
            if theme.content.indices.contains(pairIndex){
                return theme.content[pairIndex]
            } else {
                return theme.content[Int.random(in: 0..<theme.content.count)]
            }
        }
    }

    var cards: [MemoryGameModel<String>.Card] {
        model.cards
    }

    private let themes: [Theme<String>] = [
        Theme(name: "Love", numberOfPairs: 6, color: "red", content: ["😍","💕","💝","💛","💒","👩‍❤️‍💋‍👨","❣️"]),
        Theme(name: "Animals", numberOfPairs: 7, color: "brown", content: ["🐈","🐈‍⬛","🐶","🐿️","🐇","🦬","🐵"]),
        Theme(name: "Vehicles", numberOfPairs: 8, color: "blue", content: ["✈️","🚗","🚀","🚎","🚁","🛴","🏍️"]),
        Theme(name: "Food", numberOfPairs: 4, color: "yellow",content: ["🍔","🍩","🍳","🍎","🍭","🥑","🍒"]),
        Theme(name: "Sport", numberOfPairs: 7, color: "green",content: ["⚽️","🏓","🏋️‍♀️","⛹️‍♀️","🏎️","🏉","🏄‍♂️"]),
        Theme(name: "Nature", numberOfPairs: 6,color: "orange" , content: ["🔥","🌺","🌲","🌍","🌸","☀️","☘️"]),
    ]



    init() {
      currentTheme = themes[Int.random(in: 0..<themes.count)]
        model = ViewModel.createGame(from: currentTheme)
    }
}

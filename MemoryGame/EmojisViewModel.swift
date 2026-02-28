//
//  File.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import Foundation

class ViewModel {
    private let currentTheme: Theme<String>
    private let model: MemoryGameModel<String>

    private static func createGame (from theme: Theme<String>) -> MemoryGameModel<String> {
        return MemoryGameModel(numberOfPairs: theme.numberOfPairs) { pairIndex in
            if theme.content.indices.contains(pairIndex){
                return theme.content[pairIndex]
            } else {
                return theme.content[Int.random(in: 0..<theme.content.count)]
            }
        }
    }


    private let themes: [Theme<String>] = [
        Theme(name: "Love", numberOfPairs: 4, content: ["😍","💕","💝","💛","💒","👩‍❤️‍💋‍👨","❣️"]),
        Theme(name: "Animals", numberOfPairs: 4, content: ["🐈","🐈‍⬛","🐶","🐿️","🐇","🦬","🐵"]),
        Theme(name: "Vehicles", numberOfPairs: 4, content: ["✈️","🚗","🚀","🚎","🚁","🛴","🏍️"]),
        Theme(name: "Food", numberOfPairs: 4, content: ["🍔","🍩","🍳","🍎","🍭","🥑","🍒"]),
        Theme(name: "Sport", numberOfPairs: 4, content: ["⚽️","🏓","🏋️‍♀️","⛹️‍♀️","🏎️","🏉","🏄‍♂️"]),
        Theme(name: "Nature", numberOfPairs: 4, content: ["🔥","🌺","🌲","🌍","🌸","☀️","☘️"]),
    ]



    init() {
      currentTheme = themes[Int.random(in: 0..<themes.count)]
        model = ViewModel.createGame(from: currentTheme)
    }
}

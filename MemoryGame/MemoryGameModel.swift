//
//  File.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import Foundation
struct MemoryGameModel<Content: Equatable>{
    var cards: [Card]



    init (numberOfPairs: Int, contentFactory: (Int)-> Content) {
        self.cards = []
        for pairIndex in 0..<max(2, numberOfPairs){
            cards.append(Card(content: contentFactory(pairIndex), id: "\(pairIndex + 1)a"))
            cards.append(Card(content: contentFactory(pairIndex), id: "\(pairIndex + 1)a"))
            cards.shuffle()
        }
    }



    struct Card: Equatable, Identifiable{
        let isFaceUp = true
        let isMatched = false
        let isWasShown = false
        let content: Content

        var id: String
    }




}

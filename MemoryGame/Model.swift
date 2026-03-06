//
//  File.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import Foundation
struct MemoryGameModel<Content: Equatable> where Content: Hashable{
    var cards: [Card]

    init (){
        self.cards = []
        for form in ContentForm.allCases {
            for color in ContentColor.allCases {
                for fill in ContentFiling.allCases {
                    for quantite in 1...3 {
                        cards.append(Card(form: form, color: color, quantite: quantite, filling: fill))
                    }
                }
            }
        }
    }


//    mutating func choose (card: Card) {
//
//        var selectedCards: [Card] = []
//        var contentOfSelectedCards: Set<Content> = []
//
//        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id}){
//            if selectedCards.count < 3 {
//                if cards[choosenIndex].isSelected {
//                    cards[choosenIndex].isSelected = false
//                } else {
//                    cards[choosenIndex].isSelected = true
//                    contentOfSelectedCards.insert(cards[choosenIndex].content)
//                    if selectedCards.count == 3 {
//
//                    }
//                }
//
//            }
//        }
//
//
//
//    }
    struct Card: Equatable, Identifiable, Hashable{
        var isMatched = false
        var isSelected = false

        let form: ContentForm
        let color: ContentColor
        let quantite: Int
        let filling: ContentFiling

        var id = UUID()
    }



    enum ContentForm: CaseIterable{
        case rectangle
        case oval
        case diamond
    }

    enum ContentColor: CaseIterable{
        case red
        case blue
        case green
    }

    enum ContentFiling: CaseIterable{
        case empty
        case filled
        case striped
    }




}



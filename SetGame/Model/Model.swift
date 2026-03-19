//
//  File.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import Foundation
struct SetGameModel{
    var board: [Card]
    var deck: [Card]
    init (){
        self.board = []
        self.deck = []
        buildDeck()
        deck.shuffle()
        dealCardsToBoard(count: 12)

    }



    struct Card: Equatable, Identifiable, Hashable{
        var matchStatus = CardMatchState.neither
        var isSelected = false

        let shape: Shape
        let color: Color
        let quantity: Int
        let shading: Shading

        var id = UUID()
    }

    mutating func shuffle () {
        board.shuffle()
    }


    private  var matchCandidates: [Card] {board.filter({$0.isSelected && $0.matchStatus == .neither})}


    mutating func choose (card: Card) {
        resolvePreviousSelection()
        if let chosenIndex = board.firstIndex(where: {$0.id == card.id}) {

            if board[chosenIndex].matchStatus == .neither && !board[chosenIndex].isSelected {

                if matchCandidates.count == 2 {
                    board[chosenIndex].isSelected = true
                    let isMatched = isMatch()
                    updateMatchStatus(for: matchCandidates, isMatched: isMatched)

                } else {
                    board[chosenIndex].isSelected = true
                }
            } else { if board[chosenIndex].matchStatus == .neither && board[chosenIndex].isSelected {
                board[chosenIndex].isSelected = false
            }

            }
        }
    }


    private  mutating func updateMatchStatus (for selectedCards: [Card],isMatched: Bool ) {
        if isMatched {
            for card in  selectedCards{
                if let chosenIndex = board.firstIndex(where: {$0.id == card.id}) {
                    board[chosenIndex].matchStatus = .matched
                }
            }
        } else {
            for card in selectedCards {
                if let chosenIndex = board.firstIndex(where: {$0.id == card.id}) {
                    board[chosenIndex].matchStatus = .mismatched
                }
            }
        }
    }


    private func isMatch()-> Bool{

        let colorsSet: Set<Color>  = [matchCandidates[0].color,matchCandidates[1].color,matchCandidates[2].color]
        let fillingsSet: Set<Shading> = [matchCandidates[0].shading, matchCandidates[1].shading, matchCandidates[2].shading]
        let formsSet: Set<Shape> = [matchCandidates[0].shape, matchCandidates[1].shape, matchCandidates[2].shape]
        let quantitySet: Set<Int> = [matchCandidates[0].quantity, matchCandidates[1].quantity, matchCandidates[2].quantity]

        let uniqueCounts: Set<Int> = [colorsSet.count,fillingsSet.count,formsSet.count, quantitySet.count]
        if uniqueCounts.contains(2){
            return false
        } else {
            return true
        }
    }

    private mutating func resolvePreviousSelection () {
        var cardsToResolve: [Card] {board.filter({$0.matchStatus == .matched || $0.matchStatus == .mismatched })}

        for card in cardsToResolve {
            switch card.matchStatus {
            case .matched:
                if let chosenIndex = board.firstIndex(where: {$0.id == card.id}) {
                    board.remove(at: chosenIndex)
                    dealCardsToBoard(count: 1)
                }
            case .mismatched:
                if let chosenIndex = board.firstIndex(where: {$0.id == card.id}) {
                    board[chosenIndex].matchStatus = .neither
                    board[chosenIndex].isSelected = false
                }
            case .neither:
                return
            }
        }
    }



    private mutating func buildDeck () {
        for form in Shape.allCases {
            for color in Color.allCases {
                for filling in Shading.allCases {
                    for quantity in 1...3 {
                        deck.append(Card(shape: form, color: color, quantity: quantity, shading: filling))
                    }
                }
            }
        }

    }
    mutating func dealCardsToBoard(count: Int) {

        if deck.count >= count {
            if board.filter({$0.matchStatus == .matched}).count == 3 {
                resolvePreviousSelection()
            } else {

                for _ in 1...count {
                    board.append(deck.removeFirst())
                }
            }
        }
    }

    enum Shape: CaseIterable{
        case rectangle
        case oval
        case diamond
    }

    enum Color: CaseIterable{
        case red
        case blue
        case green
    }

    enum Shading: CaseIterable{
        case empty
        case filled
        case striped
    }

    enum CardMatchState {
        case matched
        case mismatched
        case neither
    }




}



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
    var discardPile = [Card]()
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
        var isFaceUp = false

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
    var matchedCards: [Card] {board.filter({$0.matchStatus  == .matched})}

    var mismatchedCards: [Card] {board.filter({$0.matchStatus  == .mismatched})}
    private mutating func resolvePreviousSelection () {
        resetMismatchedSelection()
        let matchCount = moveMatchedCardsToDiscardPile()
        if matchCount > 0 {
            dealCardsToBoard(count: matchCount)
        }
    }

    private mutating func resetMismatchedSelection () {
        for card in mismatchedCards {
            if let chosenIndex = board.firstIndex(where: {$0.id == card.id}) {
                board[chosenIndex].matchStatus = .neither
                board[chosenIndex].isSelected = false
            }
        }
    }

    private mutating func moveMatchedCardsToDiscardPile () -> Int {
        var matchCount = 0
        for card in matchedCards {
            if let chosenIndex = board.firstIndex(where: {$0.id == card.id}) {
                board[chosenIndex].isSelected = false
                discardPile.append(board.remove(at: chosenIndex))
                matchCount += 1
            }
        }
        return matchCount
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
                for card in board {
                    if let choosenIndex = board.firstIndex(where: {$0.id == card.id}) {
                        board[choosenIndex].isFaceUp = true
                    }
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



//
//  File.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import Foundation
import Combine

class ViewModel: ObservableObject{
    @Published var model: SetGameModel

    private static func createGame () -> SetGameModel {
        return SetGameModel()
    }

    var cards: [SetGameModel.Card] {
        model.board
    }
    var cardsOnTheDeck: [SetGameModel.Card]{
        model.deck
    }


    init() { model = ViewModel.createGame() }

//MARK: - Intension
     func createNewGame (){
        model = ViewModel.createGame()
         model.shuffle()

    }

    func dealThreeCardsToBoard() {
        model.dealCardsToBoard(count: 3)
    }

    func choose (card: SetGameModel.Card) {
        model.choose(card: card)
    }
}



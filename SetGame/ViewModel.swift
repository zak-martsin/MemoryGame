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
        model.cards
    }



    init() {
        model = ViewModel.createGame()
        print (cards)
    }



}



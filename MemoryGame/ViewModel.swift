//
//  File.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import Foundation
import Combine

class ViewModel: ObservableObject{
    @Published var model: MemoryGameModel<String>

    private static func createGame () -> MemoryGameModel<String> {
        return MemoryGameModel()
    }

    var cards: [MemoryGameModel<String>.Card] {
        model.cards
    }



    init() {
        model = ViewModel.createGame()
        print (cards)
    }



}



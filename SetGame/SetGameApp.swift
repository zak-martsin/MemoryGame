//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: ViewModel())
        }
    }
}

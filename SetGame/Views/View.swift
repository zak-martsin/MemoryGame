//
//  ContentView.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 28/02/2026.
//

import SwiftUI



struct SetGameView: View {
    private typealias Card = SetGameModel.Card

    @ObservedObject var viewModel: ViewModel

    @State private var dealt = Set<Card.ID>()

    @Namespace private var dealingNamespace

    var body: some View {
        VStack {
            cards
            HStack {
                discardPile
                Spacer()
                deck
            }
            HStack{
                createNewGame
                Spacer()
                shuffle
            }
        }
        .padding()
        .onAppear { syncDealtCards() }
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: Constants.aspectRatio) { card in

            if dealt.contains(card.id) {
                cardView(for: card)
                    .padding(Constants.padding)
                    .onTapGesture { viewModel.choose(card: card) }
            }
        }
    }

    private var deck: some View {
        ZStack {
            ForEach(viewModel.cardsOnTheDeck) { card in
                cardView(for: card)
            }
            .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
        }
        .onTapGesture {
            viewModel.dealThreeCardsToBoard()
            deal()
        }
    }


    private var discardPile: some View {
        ZStack {
            ForEach(viewModel.discardPile) { card in
               cardView(for: card)
                    .rotationEffect(discardRotation(for: card))
                    .offset(discardOffset(for: card))
    }
            .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
        }
    }


    private var shuffle: some View {
        Button ("Shuffle"){
            withAnimation{
                viewModel.shuffle()
            }
        }
        .font(.largeTitle)
    }



    private  var createNewGame: some View {
        Button ("New Game"){
            viewModel.createNewGame()
            syncDealtCards()
        }
        .font(.largeTitle)
    }


    private func isDealt (_ card: Card) -> Bool {
        dealt.contains(card.id)
    }


    private func deal() {
        var delay: TimeInterval = 0
        for card in undealtCards {
            withAnimation(Constants.Animations.deal.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += Constants.Animations.delay
        }
    }

    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }



    private func discardRotation(for card: Card) -> Angle {
        Angle(degrees: Double.random(in: Constants.discardRotationRange))
    }

    private func discardOffset(for card: Card) -> CGSize {
        CGSize(width: CGFloat.random(in:Constants.discardXOffsetRange),height: CGFloat.random(in:Constants.discardYOffsetRange))
    }


    private func cardView (for card: Card) -> some View {
        CardView(card: card)
            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
    }

    private func syncDealtCards() {
        dealt = Set(viewModel.cards.map(\.id))
    }


    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let deckWidth: CGFloat = 50
        static let padding: CGFloat = 4
        static let discardRotationRange: ClosedRange<Double> = -20...20
        static let discardXOffsetRange: ClosedRange<CGFloat> = -6...6
        static let discardYOffsetRange: ClosedRange<CGFloat> = -6...6

        struct Animations{
            static let delay: TimeInterval = 0.15
            static let deal: Animation = .easeInOut(duration: 0.5)
        }
    }

}















#Preview {
    SetGameView(viewModel: ViewModel())
}







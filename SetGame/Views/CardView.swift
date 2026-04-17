//
//  CardView.swift
//  SetGame
//
//  Created by Захар Марцинкевич on 06/03/2026.
//
import SwiftUI


struct CardView: View {
    let card: SetGameModel.Card
    @State private var offset: CGFloat = 0


    var body: some View {
        GeometryReader { geo in
            ZStack{
                Group{
                    let base = RoundedRectangle(cornerRadius: Constants.radius)

                    base.fill(.white)
                    base.strokeBorder(cardColor,lineWidth: Constants.linewidth)
                    SymbolsView(card: card,size: geo.size)
                        .opacity(faceUpOpacity)
                    base.fill(.orange)
                        .opacity(faceDownOpacity)
                }
                .scaleEffect(selectionScale)
                .rotationEffect(matchRotation)
                .offset(x: offset)
                .animation(.default, value: card.isSelected)
                .animation(matchAnimatiom, value: card.matchStatus)
                .onChange(of: card.matchStatus) {
                    triggerMismatchAnimation()
                }
            }
        }
    }



    private  func triggerMismatchAnimation  () {
        if card.matchStatus == .mismatched {
            offset = -Constants.Animations.mismatchOffset
            withAnimation (.linear(duration: Constants.Animations.mismatchDuration).repeatCount(Constants.Animations.repeatCount, autoreverses: true)){
                offset = Constants.Animations.mismatchOffset
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Animations.dispatchDeadline) {
                offset = 0
            }
        }

    }

    private var faceUpOpacity: CGFloat {card.isFaceUp ? 1 : 0}
    private var faceDownOpacity: CGFloat {card.isFaceUp ? 0 : 1}
    private var selectionScale: CGFloat {card.isSelected ? Constants.scale : 1}
    private var matchRotation: Angle {.degrees(card.matchStatus == .matched ? Constants.angle : 0)}
    private var matchAnimatiom: Animation {.linear(duration: Constants.Animations.matchDuration).repeatCount(1, autoreverses: false)}


    private var cardColor: Color {
        switch visualState {
        case .normal:
                .black
        case .selected:
                .blue
        case .matched:
                .green
        case .mismatched:
                .red
        }
    }

    private var visualState: CardVisualState {
        switch (card.isSelected, card.matchStatus) {
        case (false, .neither):
            return .normal
        case (true, .neither):
            return .selected
        case (_, .matched):
            return .matched
        case (_, .mismatched):
            return .mismatched
        }
    }

 private enum CardVisualState{
        case normal
        case selected
        case matched
        case mismatched
    }


    private struct Constants{
        static let linewidth: CGFloat = 4
        static let radius: CGFloat = 12
        static let scale: CGFloat = 1.05
        static let angle: Double = 180
        struct Animations {
            static let matchDuration: TimeInterval = 0.3
            static let mismatchDuration: TimeInterval = 0.2
            static let dispatchDeadline: TimeInterval = 0.14
            static let repeatCount: Int = 2
            static let mismatchOffset: CGFloat = 4
        }
    }
}

//
//  DiamondShape.swift
//  MemoryGame
//
//  Created by Захар Марцинкевич on 05/03/2026.
//

import SwiftUI

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()


        let top = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX , y: rect.midY)
        let right = CGPoint(x: rect.maxX , y: rect.midY)
        let bottom = CGPoint(x: rect.midX , y: rect.maxY)


        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: bottom)
        path.addLine(to: right)
        path.closeSubpath()


        return path
    }


}


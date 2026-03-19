//
//  StripesShape.swift
//  SetGame
//
//  Created by Захар Марцинкевич on 06/03/2026.
//

import SwiftUI

struct StripesShape: Shape {
    var spacing: CGFloat = 5
    func path(in rect: CGRect) -> Path {
        var path = Path()

        var x: CGFloat =  rect.minX

        while x < rect.maxX {
            path.move(to: CGPoint(x: x, y: rect.minY))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
            x += spacing
        }
        return path
    }


}


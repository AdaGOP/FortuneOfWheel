//
//  Triangle.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 08/06/22.
//

import Foundation
import SwiftUI

// MARK: Create custom triangle shape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

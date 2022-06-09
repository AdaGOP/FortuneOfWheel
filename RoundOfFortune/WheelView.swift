//
//  WheelView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/05/22.
//

import SwiftUI

struct WheelView: View {
    @State private var radius: Double = 150 // Circle Radius
    
//    @Binding var chosenIndex: Int // Index of the chosen element
    @State private var chosenIndex: Int = 0
    
    @Binding var degree: Double // Degree of circle
    @Binding var array: [theValue] // Element showed in the circle
    let circleSize: Double
    
    var body: some View {
        ZStack {
            // Store the angle per part, if we have n partition, its angle will be (2*Pi)/n - Pi = 180 degree
            let anglePerCount = Double.pi * 2.0 / Double(array.count)
            
            // MARK: WHEEL STACK - BEGINNING
            ZStack{
                // Create Circle view with gradient and hue rotation effect color
                Circle().fill(EllipticalGradient(colors: [.orange, .yellow]))
                    .hueRotation(Angle(degrees: degree))
                
                // Create view for each partition
                ForEach(0 ..< array.count, id: \.self) { index in
                    /// Define angle per partition from initial Circle degree at 0
                    let angle = Double(index) * anglePerCount
                    
                    /// Define (x,y) position depends on the angle (pythagoras) to set up the distance (offset)
                    let xOffset = CGFloat(radius * cos(angle))
                    let yOffset = CGFloat(radius * sin(angle))
                    
                    /// Create the view to display the option index
                    Text("\(array[index].val)")
                        .rotationEffect(Angle(degrees: degree))
                        .offset(x: xOffset, y: yOffset)
                        .font(Font.system(chosenIndex == index ? .largeTitle : .title2, design: .monospaced))
                }
                
            }
            .rotationEffect(Angle(degrees: degree))
            .onAppear() {
                radius = circleSize/2 - 30 // 30 is for padding
            }
            
        }
        .frame(width: circleSize, height: circleSize)
    }
}

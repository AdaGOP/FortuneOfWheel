//
//  WheelView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/05/22.
//

import SwiftUI

struct WheelView: View {
    // Circle Radius
    @State var radius: Double = 150
    
    // Direction of swipe
    @State var direction = Direction.left
    
    // index of the number at the bottom of the circle
    @State var chosenIndex = 0
    
    // degree of circle and hue
    @Binding var degree: Double
    
    let array: [theValue]
    let circleSize: Double
    
    var body: some View {
        ZStack {
            let anglePerCount = Double.pi * 2.0 / Double(array.count)
            let drag = DragGesture()
                .onEnded { value in
                    if value.startLocation.x > value.location.x + 10 {
                        direction = .left
                    } else if value.startLocation.x < value.location.x - 10 {
                        direction = .right
                    }
                    moveWheel()
                }
            
            // MARK: WHEEL STACK - BEGINNING
            ZStack{
                Circle().fill(EllipticalGradient(colors: [.orange, .yellow]))
                    .hueRotation(Angle(degrees: degree))
                ForEach(0 ..< array.count) { index in
                    let angle = Double(index) * anglePerCount
                    let xOffset = CGFloat(radius * cos(angle))
                    let yOffset = CGFloat(radius * sin(angle))
                    Text("\(array[index].val)")
                        .rotationEffect(Angle(degrees: degree))
                        .offset(x: xOffset, y: yOffset)
                        .font(Font.system(chosenIndex == index ? .title : .body, design: .monospaced))
                }
            }
            .rotationEffect(Angle(degrees: degree))
            .gesture(drag)
            .onAppear() {
                radius = circleSize/2 - 30 // 30 is for padding
            }
            // MARK: WHEEL STACK - END
            
        }
        .frame(width: circleSize, height: circleSize)
        
        
    }
    
    
    func moveWheel() {
        withAnimation(.spring()){
            if direction == .left {
                degree += Double(360/array.count)
                if chosenIndex == 0 {
                    chosenIndex = array.count - 1
                } else {
                    chosenIndex -= 1
                }
            } else {
                degree -= Double(360/array.count)
                if chosenIndex == array.count-1 {
                    chosenIndex = 0
                } else {
                    chosenIndex += 1
                }
            }
        }
    }
}

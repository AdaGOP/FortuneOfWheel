//
//  WheelView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/05/22.
//

import SwiftUI

struct WheelView: View {
    @State var radius: Double = 150 // Circle Radius
    @State var direction = Direction.left // Direction of swipe
    @State var chosenIndex = 0 // Index of the chosen element
    @Binding var degree: Double // Degree of circle
    @Binding var array: [theValue] // Element showed in the circle
    let circleSize: Double
    
    var body: some View {
        ZStack {
            // Store the angle per part, if we have n partition, its angle will be (2*Pi)/n - Pi = 180 degree
            let anglePerCount = Double.pi * 2.0 / Double(array.count)
            
            // Here we define the gesture to move the wheels
            let drag = DragGesture()
                .onEnded { value in
                    // Check possibility range from the starting potition to define move direction
                    if value.startLocation.x > value.location.x + 10 {
                        direction = .left
                    } else if value.startLocation.x < value.location.x - 10 {
                        direction = .right
                    }
                    
                    // Ensure if there is no data, no move happens
                    if array.count != 0 {
                        moveWheel()
                    }
                }
            
            // MARK: WHEEL STACK - BEGINNING
            ZStack{
                // Create Circle view with gradient and hue rotation effect color
                Circle().fill(EllipticalGradient(colors: [.orange, .yellow]))
                    .hueRotation(Angle(degrees: degree))
                
                // Create view for each partition
                ForEach(0 ..< array.count, id: \.self) { index in
                    // Define angle per partition from initial Circle degree at 0
                    let angle = Double(index) * anglePerCount
                    // Define (x,y) position depends on the angle (pythagoras) to set up the distance (offset)
                    let xOffset = CGFloat(radius * cos(angle))
                    let yOffset = CGFloat(radius * sin(angle))
                    
                    // Create the view to display the option index
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
            let randomInt = Int.random(in: 0 ..< array.count)
            if direction == .left {
                degree += Double(360/array.count)
                if chosenIndex == 0 {
                    chosenIndex = array.count - 1
                } else {
                    chosenIndex -= 1
                }
            } else {
                degree -= Double(360/array.count)
                if chosenIndex == array.count - 1 {
                    chosenIndex = 0
                } else {
                    chosenIndex += 1
                }
            }
        }
    }
}

//
//  WheelView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/05/22.
//

import SwiftUI

// MARK: Create Class to display the wheel
struct WheelView: View {
    // STEP 1: Set the initial value of the circle's radius and chosen option index that will be used to adjust the view if any changes happen
    @State private var radius: Double = 150
    @State private var chosenIndex: Int = 0
    
    // STEP 2: Create a two-way connection between a property that stores data, and a view that displays and changes the data
    @Binding var degree: Double // Rotation degree towards circle's animation
    var wheelOptions: [WheelOption] // Element showed in the circle
    
    // STEP 3: Set constant parameter value for the size of the circle view, it is required when the WheelView is called
    let circleSize: Double
    
    // STEP 4: Configure the view
    var body: some View {
        
            /// Store the angle per part, if we have n partition, its angle will be (2*Pi)/n - Pi = 180 degree
            let anglePerCount = Double.pi * 2.0 / Double(wheelOptions.count)
            
            // MARK: WHEEL STACK - BEGINNING
            // STEP 5: Create view that overlays items needed in the circle view, aligning them in both axes
            ZStack{
                /// Create Circle view with gradient and hue rotation effect color
                Circle().fill(EllipticalGradient(colors: [.orange, .yellow]))
                    .hueRotation(Angle(degrees: degree))
                    .frame(width: circleSize,height: circleSize)
                
                
                /// Create view for each partition
                ForEach(0 ..< wheelOptions.count, id: \.self) { index in
                    /// Define angle per partition from initial Circle degree at 0
                    let angle = Double(index) * anglePerCount
                    
                    /// Define (x,y) position depends on the angle (pythagoras) to set up the distance (offset)
                    let xOffset = CGFloat(radius * cos(angle))
                    let yOffset = CGFloat(radius * sin(angle))
                    
                    /// Create the view to display the option index
                    Text("\(wheelOptions[index].name)")
                        .rotationEffect(Angle(degrees: degree))
                        .offset(x: xOffset, y: yOffset)
                        .font(Font.system(chosenIndex == index ? .largeTitle : .title2, design: .monospaced))
                }
                
            }
            .rotationEffect(Angle(degrees: degree))
            .onAppear() {
                radius = circleSize/2 - 30 /// 30 is for padding
            }
            // MARK: WHEEL STACK - END
    }
}

struct WheelView_Preview: PreviewProvider {
    
    static var previews: some View {
        let viewModel: MainWheelViewModel = {
            let m = MainWheelViewModel()
            m.add(newWheelOptionString: "Hello")
            m.add(newWheelOptionString: "abang")
            return m
        }()
        
        WheelView(degree: .constant(80.0), wheelOptions: viewModel.options, circleSize: 300)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Color 1")
        WheelView(degree: .constant(180.0), wheelOptions: viewModel.options, circleSize: 300)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Color 2")
    }
}

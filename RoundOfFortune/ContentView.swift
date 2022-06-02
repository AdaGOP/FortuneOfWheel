//
//  ContentView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/04/22.
//

import SwiftUI

struct ContentView: View {
    @State var degree = 90.0
    let array: [theValue] = [theValue(val: "0"),
                             theValue(val: "1"),
                             theValue(val: "2"),
                             theValue(val: "3"),
                             theValue(val: "4"),
                             theValue(val: "5"),
                             theValue(val: "6"),
                             theValue(val: "7"),
                             theValue(val: "8"),
                             theValue(val: "9"),
                             theValue(val: "10")]
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.orange.opacity(0.4).ignoresSafeArea()
                .hueRotation(Angle(degrees: degree))
            WheelView(degree: $degree, array: array, circleSize: 300)
                .offset(y: 0)
                .shadow(color: .white, radius: 4, x: 0, y: 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

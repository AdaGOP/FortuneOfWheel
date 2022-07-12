//
//  ContentView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/04/22.
//

import SwiftUI

// MARK: Create main view that put all views and functionality needed
struct ContentView: View {
    
    @State var degree = 0.0 /// rotation value
    @State var arrayIndeks: [theValue] = [] /// option index
    @State private var optionsListWithIndex: [Int : String] = [:] /// key-value for the option list with the index to be displayed
    @State private var valueIndex: Int = 0 /// temporary Index
    @State var chosenIndex: Int = 0
    @State private var textOption: String = "" /// temporary variable to store value and handle data changes in the textfield
    @State private var showingResult = false
    @State private var result = ""
    
    // MARK: Configure the view
    var body: some View {
        // MARK: 1. Create view that overlays background color and all views, aligning them in both axes
        ZStack() {
            // Set background view color
            // Write the code here
            
            // MARK: 2. Create view that arranges the views in vertical line
            VStack(alignment: .leading, spacing: 10){
                /// Set blank space
                Spacer()
                    .frame(height: 100)
                
                // MARK: 2.1 Create view that overlays WheelView, Triangle, and Circle Button
                ZStack(){
                    // Write the code here
                    
                }
                .popover(isPresented: $showingResult) {
                    ResultView(result: $result, optionsListWithIndex: $optionsListWithIndex, arrayIndeks: $arrayIndeks, valueIndex: $valueIndex)
                }
                
                /// Set spacer
                Spacer()
                    .frame(height: 20)
                
                // MARK: 2.2 Create view that arranges label Option List and button Reset in horizontal line
                HStack(){
                    // Write the code here
                    
                }
                
                // MARK: 2.3 Create view that arranges TextField and Add Option button in horizontal line
                HStack{
                    // Write the code here
                    
                }
                
                // MARK: 3. Create scrollable view
                // Write the code here
            }
            
        }
    }
    
    // Create function to animate the circle view when the play button is tapped
    func moveWheel() {
        let randomInt = Int.random(in: 0 ..< arrayIndeks.count)
        chosenIndex = randomInt
        result = "Our wheel say that \(optionsListWithIndex[Int(arrayIndeks[chosenIndex].val) ?? 0] ?? "")"
        arrayIndeks.swapAt(0, chosenIndex)
        chosenIndex = 0
        for _ in 0 ..< 750 {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.83, blendDuration: 0.5)){
                
                degree += Double((360/arrayIndeks.count))
                
            }
        }
        degree = 0
    }
    
    // Create function to reset data before start from beginning
    func resetData() {
        optionsListWithIndex.removeAll()
        arrayIndeks.removeAll()
        valueIndex = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  PlayWheelView.swift
//  RoundOfFortune
//
//  Created by Haryanto Salim on 18/07/22.
//

import SwiftUI

struct PlayWheelView: View {
    @EnvironmentObject var mySettings: RoundOfFortuneSettings
    
    @State var chosenIndex: Int = 0
    @State var degree = 0.0 /// rotation value
    @State private var showingResult = false
    @State private var result = ""
    
    var body: some View {
        // MARK: Create view that overlays background color and all views, aligning them in both axes
        ZStack{
            /// Set view color
            Color.orange.opacity(0.4).ignoresSafeArea()
                .hueRotation(Angle(degrees: degree))
            
            // MARK: Create view that arranges the views in vertical line
            GeometryReader { geometry in
#if !os(macOS)
                let bounds = UIScreen.main.bounds
#else
                let bounds = geometry.size//NSScreen.main?.visibleFrame.size
#endif
                VStack(alignment: .center, spacing: 10){
                    /// Set blank space
                    //                Spacer()
                    //                    .frame(height: 100)
                    
                    // MARK: Create view that overlays WheelView, Triangle, and Circle Button
                    
                    ZStack(){
                        
                        WheelView(degree: $degree, array: $mySettings.arrayIndeks, circleSize: (bounds.width)/1.25)
                        //                        .offset(y: -60)
                            .shadow(color: .white, radius: 4, x: 0, y: 0)
                        Triangle()
                            .fill(.red)
                            .frame(width: (bounds.width) / 5, height: (bounds.height) / 14, alignment: .trailing)
                            .offset(x:0, y: (bounds.width)/2.3)
                            .rotationEffect(.degrees(-90))
                        
                        Button {
                            if mySettings.arrayIndeks.count != 0 {
                                moveWheel()
                                //                        }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showingResult = true
                                }
                            }
                        } label: {
                            Text(mySettings.arrayIndeks.count != 0 ? "Play" : "Add data below")
                                .font(mySettings.arrayIndeks.count != 0 ? .title2 : .subheadline)
                        }
                        .padding()
                        .frame(width: (bounds.width)/4, height: (bounds.width)/4, alignment: .center)
                        .background(.white)
                        .foregroundColor(.orange)
                        .clipShape(Circle())
                    }.navigationTitle("Wheel Of Fortune")
                        .sheet(isPresented: $showingResult) {
                            ResultView(result: $result, optionsListWithIndex: $mySettings.optionsListWithIndex, arrayIndeks: $mySettings.arrayIndeks, valueIndex: $mySettings.valueIndex).frame(width: bounds.width, height: bounds.height, alignment: .center)
                        }
                }
            }
        }
    }
    
    func moveWheel() {
        let randomInt = Int.random(in: 0 ..< mySettings.arrayIndeks.count)
        chosenIndex = randomInt
        result = "Our wheel say that \(mySettings.optionsListWithIndex[Int(mySettings.arrayIndeks[chosenIndex].val) ?? 0] ?? "")"
        mySettings.arrayIndeks.swapAt(0, chosenIndex)
        chosenIndex = 0
        for _ in 0 ..< 750 {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.83, blendDuration: 0.5)){
                
                degree += Double((360/mySettings.arrayIndeks.count))
                
            }
        }
        degree = 0
    }
}

#if DEBUG
struct PlayWheelView_Previews: PreviewProvider {
    static var previews: some View {
        PlayWheelView().environmentObject(RoundOfFortuneSettings())
    }
}
#endif

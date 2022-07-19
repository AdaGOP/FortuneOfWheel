//
//  InteractiveWheelView.swift
//  RoundOfFortune
//
//  Created by octavianus on 17/06/22.
//

import Foundation
import SwiftUI

struct WheelViewWithComponents: View{
    @EnvironmentObject var mainWheelViewModel: MainWheelViewModel
    
    @Binding var degree: Double
    @Binding var showingResult: Bool
    
    var body: some View{
        ZStack(){
            WheelView(degree: $degree, wheelOptions: mainWheelViewModel.options, circleSize: UIScreen.main.bounds.width * 0.95)
                .shadow(color: .white, radius: 4, x: 0, y: 0)
            Triangle()
                .fill(.red)
                .opacity(0.96)
                .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.height / 14, alignment: .trailing)
                .offset(x:0, y: UIScreen.main.bounds.width / 2.3)
                .rotationEffect(.degrees(-90))
            
            Button {
                
                if mainWheelViewModel.options.count != 0 {
                    mainWheelViewModel.getSpinWheelNewIndex()
                    for _ in 0 ..< 750 {
                        withAnimation(.spring(response: 1, dampingFraction: 0.83, blendDuration: 0.5)){
                            degree += 50
                        }
                    }
                    degree = Math().getSelectedAngle(
                        from: mainWheelViewModel.chosenIndex,
                        totalOptions: mainWheelViewModel.options.count)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        showingResult = true
                    }
                }
            } label: {
                Text(!mainWheelViewModel.options.isEmpty ? "Play" : "Add data below")
                    .font(!mainWheelViewModel.options.isEmpty  ? .title2 : .subheadline)
            }
            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4, alignment: .center)
            .background(.white)
            .foregroundColor(.orange)
            .clipShape(Circle())
        }
    }
}


struct WheelViewWithComponents_Preview: PreviewProvider {
    
    static var previews: some View {
        let viewModel: MainWheelViewModel = {
            let m = MainWheelViewModel()
            m.add(newWheelOptionString: "Hello")
            m.add(newWheelOptionString: "abang")
            return m
        }()
        
        WheelViewWithComponents(degree: .constant(20.0), showingResult: .constant(false))
            .environmentObject(viewModel)
            .previewLayout(.sizeThatFits)
    }
}


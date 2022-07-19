//
//  MainWheelViewModel.swift
//  RoundOfFortune
//
//  Created by octavianus on 27/06/22.
//

import SwiftUI


class MainWheelViewModel: ObservableObject{
    
    //MARK: Object that want to be published
    @Published var options: [WheelOption] = []
    @Published var chosenIndex = 0

    private var networkManager: NetworkManager = NetworkManager()
    
    public func prefetchOptionsData(){
        networkManager.prefetchOptionsData { fetchedOptions in
            self.options = fetchedOptions
        }
    }
    
    public func add(newWheelOptionString: String){
        options.append(WheelOption(name: newWheelOptionString))
    }
    
    public func resetOption(){
        options.removeAll()
    }
    
    public func getSpinWheelNewIndex(){
        if !options.isEmpty{
            let randomInt = Int.random(in: 0 ..< options.count)
            chosenIndex = randomInt
        }
    }
    

}

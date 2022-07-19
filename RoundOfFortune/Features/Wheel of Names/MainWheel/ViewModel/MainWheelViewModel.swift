//
//  MainWheelViewModel.swift
//  RoundOfFortune
//
//  Created by octavianus on 27/06/22.
//

import SwiftUI


class MainWheelViewModel{
    
    //MARK: Object that want to be published
    var options: [WheelOption] = []
    var chosenIndex = 0

    private var networkManager: NetworkManager = NetworkManager()
    
    public func prefetchOptionsData(){

    }
    
    public func add(newWheelOptionString: String){
       
    }
    
    public func resetOption(){
        
    }
    
    public func getSpinWheelNewIndex(){

    }
}

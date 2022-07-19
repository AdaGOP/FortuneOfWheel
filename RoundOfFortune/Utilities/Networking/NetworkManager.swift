//
//  NetworkManager.swift
//  RoundOfFortune
//
//  Created by octavianus on 08/07/22.
//

import Foundation


class NetworkManager{
    
    public func prefetchOptionsData(onComplete: @escaping ([WheelOption]) -> ()){
        Timer(timeInterval: 2, repeats: false) { timer in
            let options = [
                WheelOption(name: "Okat"),
                WheelOption(name: "boss")
            ]
            onComplete(options)
        }.fire()
    }
    
}

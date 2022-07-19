//
//  Math.swift
//  RoundOfFortune
//
//  Created by octavianus on 19/07/22.
//

import Foundation

struct Math{
    func getSelectedAngle(from index: Int,totalOptions: Int) -> Double{
        let perAngle = (360 / Double(totalOptions))
        return -perAngle * (Double(index))
    }
}


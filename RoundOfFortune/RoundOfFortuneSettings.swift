//
//  RoundOfFortuneConfig.swift
//  RoundOfFortune
//
//  Created by Haryanto Salim on 18/07/22.
//

import Foundation
import SwiftUI

class RoundOfFortuneSettings: ObservableObject {
    @Published var valueIndex = 0
    @Published var optionsListWithIndex: [Int : String] = [:]
    @Published var arrayIndeks: [theValue] = []
}

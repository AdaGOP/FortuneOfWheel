//
//  WheelView-value.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/05/22.
//

import Foundation
#if !os(macOS)
import UIKit
#endif
// MARK: Create object that can be used to add the option value in the circle
struct theValue: Equatable, Hashable{
    let val : String
}

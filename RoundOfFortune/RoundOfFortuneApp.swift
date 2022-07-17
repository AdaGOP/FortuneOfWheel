//
//  RoundOfFortuneApp.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/04/22.
//

import SwiftUI

@main
struct RoundOfFortuneApp: App {
//    @EnvironmentObject var mySettings = RoundOfFortuneSettings
    var body: some Scene {
        WindowGroup {
            FortuneLandingView().environmentObject(RoundOfFortuneSettings())
        }
    }
}

//
//  RoundOfFortuneApp.swift
//  RoundOfFortuneWatch WatchKit Extension
//
//  Created by Allicia Viona Sagi on 20/07/22.
//

import SwiftUI

@main
struct RoundOfFortuneApp: App {
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                //ContentView()
                FortuneLandingView().environmentObject(RoundOfFortuneSettings())
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

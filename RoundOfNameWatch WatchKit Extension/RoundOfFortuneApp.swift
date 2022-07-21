//
//  RoundOfFortuneApp.swift
//  RoundOfNameWatch WatchKit Extension
//
//  Created by Allicia Viona Sagi on 21/07/22.
//

import SwiftUI

@main
struct RoundOfFortuneApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                FortuneLandingView().environmentObject(RoundOfFortuneSettings())
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

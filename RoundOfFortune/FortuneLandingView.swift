//
//  FortuneLandingView.swift
//  RoundOfFortune
//
//  Created by Haryanto Salim on 18/07/22.
//

import SwiftUI

struct FortuneLandingView: View {
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
#endif
    
    @EnvironmentObject var mySettings: RoundOfFortuneSettings
    
    var body: some View {
        
#if os(iOS)
        if horizontalSizeClass == .compact {
            AppTabNavigation()
        } else {
            AppSidebarNavigation()
        }
#elseif os(watchOS)
        AppTabNavigation()
#elseif os(tvOS)
        AppTabNavigation()
#else
        AppSidebarNavigation()
            .frame(minWidth: 900, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
#endif
    }
    
    func AppTabNavigation() -> some View{
        TabView{
            NavigationView{
                AddOptionListView()
                    .environmentObject(mySettings)
#if !os(macOS)
                    .listStyle(.insetGrouped)
#else
                    .listStyle(.inset(alternatesRowBackgrounds: false))
#endif
            }.tabItem {
                Label("OptionList", systemImage: "list.number")
            }
            
            NavigationView{
                PlayWheelView()
                    .environmentObject(mySettings)
#if !os(macOS)
                    .listStyle(.insetGrouped)
#else
                    .listStyle(.inset(alternatesRowBackgrounds: false))
#endif
                
            }.tabItem {
                Label("Turn Wheel", systemImage: "play.circle")
            }
        }
    }
    
    func AppSidebarNavigation() -> some View{
        NavigationView{
            List{
                NavigationLink(destination:
                                AddOptionListView()
                    .environmentObject(mySettings), label: {
                        Label("OptionList", systemImage: "list.number")
                    })
                
                NavigationLink(destination:
                                PlayWheelView()
                    .environmentObject(mySettings)
                               , label: {
                    Label("Turn Wheel", systemImage: "play.circle")
                })
            }.listStyle(.sidebar)
        }
#if !os(macOS)
        .navigationViewStyle(.columns)
#endif
    }
}
#if DEBUG
struct FortuneLandingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FortuneLandingView().environmentObject(RoundOfFortuneSettings())
#if !os(macOS)
            FortuneLandingView().previewDevice("iPad Pro (9.7-inch)").environmentObject(RoundOfFortuneSettings())
            FortuneLandingView().previewDevice("iPhone SE (3rd generation)").environmentObject(RoundOfFortuneSettings())
#endif
        }
    }
}
#endif

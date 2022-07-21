//
//  OptionListView.swift
//  RoundOfFortune
//
//  Created by Haryanto Salim on 18/07/22.
//
import SwiftUI

struct OptionListView: View {
    
    @EnvironmentObject var mySettings: RoundOfFortuneSettings
    
    var body: some View {
        // MARK: Create scrollable view
        GeometryReader { geometry in
#if !os(macOS) && !os(watchOS)
            let bounds = UIScreen.main.bounds
#else
            let bounds = geometry.size//NSScreen.main?.visibleFrame.size
#endif
            
            ScrollView{
                ForEach(mySettings.arrayIndeks, id: \.self) { indeks in
                    /// Set the option list displayed in vertical line
                    VStack{
                        /// Set the elemen of each list displayed in horizontal line
                        HStack{
                            Text("\(indeks.val)")
                            Text(mySettings.optionsListWithIndex[Int(indeks.val) ?? 0] ?? "")
                                .font(.body)
                        }
                        .frame(width: (bounds.width) - 50, alignment: .leading)
                        Divider()
                    }
                }
            }//.frame(minWidth: 300, idealWidth: 450, maxWidth: 980, minHeight: 150, idealHeight: 150, maxHeight: 180, alignment: .leading)
        }
    }
}
#if DEBUG
struct OptionListView_Previews: PreviewProvider {
    static var previews: some View {
        OptionListView().environmentObject(RoundOfFortuneSettings())
    }
}
#endif

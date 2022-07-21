//
//  OptionListView.swift
//  RoundOfFortune
//
//  Created by Haryanto Salim on 18/07/22.
//

import SwiftUI

struct AddOptionListView: View {
    @EnvironmentObject var mySettings: RoundOfFortuneSettings
    
    @State private var textOption: String = "" /// temporary variable to store value and handle data changes in the textfield
    
    var body: some View {
        ZStack{
            Color.orange.opacity(0.4).ignoresSafeArea()
            VStack{
                HStack(){
                    Spacer(minLength: 20.0)
//                    Text("Option List")
//                        .font(.title2)
//                        .bold()
//                        .frame(alignment: .leading)
                    Spacer()
                        .frame(minWidth: 100, idealWidth: 500, maxWidth: 780, alignment: .leading)
                    Button {
                        resetData()
                    } label: {
                        Label("Reset", systemImage: "repeat")
                    }
                    .foregroundColor(.red)
                    Spacer()
                    
                }
                
                // MARK: Create view that arranges TextField and Add Option button in horizontal line
                HStack{
                    Spacer(minLength: 20.0)
                    TextField(
                        "Input text option here",
                        text: $textOption
                    )
                    .font(.system(size: 15))
#if !os(watchOS)
                    .textFieldStyle(.roundedBorder)
#else
                    .textFieldStyle(.automatic)
#endif
                    Button(action: {
                        addOptionItem()
                    }) {
                        Label("Add Option", systemImage: "plus")
                            .font(.system(size: 15))
                    }
                    .padding(8)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    Spacer()
                }
                //
                // MARK: Create scrollable view
                OptionListView().environmentObject(mySettings)
            }
        }.navigationTitle("Option List")
    }
    
    func addOptionItem() {
        mySettings.valueIndex += 1
        mySettings.optionsListWithIndex[mySettings.valueIndex] = textOption
        mySettings.arrayIndeks.append(theValue(val: "\(mySettings.valueIndex)"))
        textOption = ""
    }
    
    func resetData() {
        mySettings.optionsListWithIndex.removeAll()
        mySettings.arrayIndeks.removeAll()
        mySettings.valueIndex = 0
    }
}

struct AddOptionListView_Previews: PreviewProvider {
    static var previews: some View {
        AddOptionListView().environmentObject(RoundOfFortuneSettings())
    }
}

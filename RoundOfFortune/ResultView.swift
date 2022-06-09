//
//  ResultView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 09/06/22.
//

import SwiftUI

struct ResultView: View {
    
    @Binding var result: String
    @Binding var optionsListWithIndex: [Int : String]
    @Binding var arrayIndeks: [theValue]
    @Binding var valueIndex: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Image("congrats")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.23, height: UIScreen.main.bounds.width/1.23, alignment: .center)
                .fixedSize()
            Text("Congratulations!")
                .font(.headline)
            Text("\(result) is your fortune!")
                .font(.body)
            Spacer()
                .frame(height: 30)
            Button {
                print("back")
                presentationMode.wrappedValue.dismiss()
                optionsListWithIndex.removeValue(forKey: Int(arrayIndeks[0].val) ?? 0)
                arrayIndeks.remove(at: 0)
                
                if arrayIndeks.count == 0 {
                    optionsListWithIndex.removeAll()
                    arrayIndeks.removeAll()
                    valueIndex = 0
                }
            } label: {
                Text("OK")
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(20)

        }
    }
}

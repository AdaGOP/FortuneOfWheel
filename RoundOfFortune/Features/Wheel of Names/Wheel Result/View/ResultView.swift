//
//  ResultView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 09/06/22.
//

import SwiftUI

// MARK: Create Class to display the result
struct ResultView: View {
    // STEP 1: Create a two-way connection between a property that stores data, and a view that displays and changes the data
    var winnerName: String
    var onDismiss: (()->())?
    
    // STEP 2: Set property wrapper to dismiss the view
    @Environment(\.presentationMode) var presentationMode
    
    // STEP 3: Configure the view
    var body: some View {
        // MARK: Create view that arranges image, text, and button in vertical line
        VStack{
            Image("congrats")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.23, height: UIScreen.main.bounds.width/1.23, alignment: .center)
                .fixedSize()
            Text("Congratulations!")
                .font(.headline)
            Text("\(winnerName) is your fortune!")
                .font(.body)
            Spacer()
                .frame(height: 30)
            Button {
                presentationMode.wrappedValue.dismiss()
                onDismiss?()
            } label: {
                Text("OK")
            }
            .frame(
                width: UIScreen.main.bounds.width * 0.6,
                height: 50)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(20)

        }
    }
}

struct ResultView_preview: PreviewProvider {
    static var previews: some View {
        ResultView(winnerName: "Octa")
    }
}

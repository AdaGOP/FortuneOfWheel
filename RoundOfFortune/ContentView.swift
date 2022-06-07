//
//  ContentView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/04/22.
//

import SwiftUI

struct ContentView: View {
    /// @State we use to mark if you want to change a property’s value while your program runs
    // Variable to set up the degree to start
    @State var degree = 0.0
    
    // Variable to store textfield input
    @State private var textOption: String = ""
    
    // Array to store the options for the wheel
    @State private var optionsListWithIndex: [Int : String] = [:]
    @State private var valueIndex: Int = 0
    @State var arrayIndeks: [theValue] = []
    
    
    var body: some View {
        ZStack() {
            Color.orange.opacity(0.4).ignoresSafeArea()
                .hueRotation(Angle(degrees: degree))
            VStack(alignment: .center, spacing: 10){
                Spacer()
                ZStack(){
                    WheelView(degree: $degree, array: $arrayIndeks, circleSize: 300)
                        .offset(y: -100)
                        .shadow(color: .white, radius: 4, x: 0, y: 0)
                    if arrayIndeks.count == 0 {
                        VStack {
                            Text("No data is available.")
                            Text("Add some below")
                        }
                        .frame(width: 200, height: 200, alignment: .center)
                        .foregroundColor(Color.primary)
                        .offset(y: -100)
                    }
                }
                
                HStack(){
                    Spacer()
                    Text("Option List")
                        .font(.title2)
                        .bold()
                        .frame(alignment: .leading)
                    Spacer()
                        .frame(width: 165)
                    Button {
                        optionsListWithIndex.removeAll()
                        arrayIndeks.removeAll()
                        valueIndex = 0
                    } label: {
                        Label("Reset", systemImage: "repeat")
                    }
                    .foregroundColor(.red)
                    .cornerRadius(8)
                    Spacer()
                    
                }
                
                HStack{
                    Spacer(minLength: 20.0)
                    TextField(
                        "Input text option here",
                        text: $textOption
                    )
                    .font(.system(size: 15))
                    .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        valueIndex += 1
                        optionsListWithIndex[valueIndex] = textOption
                        arrayIndeks.append(theValue(val: "\(valueIndex)"))
                        textOption = ""
                    }) {
                        Label("Add option", systemImage: "plus")
                            .font(.system(size: 15))
                    }
                    .padding(8)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    Spacer()
                }
                ScrollView{
                    ForEach(arrayIndeks, id: \.self) { indeks in
                        VStack{
                            HStack{
                                Text("\(indeks.val)")
                                Text(optionsListWithIndex[Int(indeks.val) ?? 0] ?? "")
                                    .font(.system(.body))
                            }
                            .frame(width: 340, height: 20, alignment: .leading)
                            Divider()
                            
                        }
                    }
                }
                .frame(width: 350, height: 150, alignment: .center)
            }
            
        }
    }
    
    func findKeyForValue(value: String, dictionary: [theValue: String]) ->String?
    {
        for (key, string) in dictionary
        {
            if (string.contains(value))
            {
                return key.val
            }
        }
        
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

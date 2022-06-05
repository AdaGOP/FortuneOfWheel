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
    @State private var optionsListWithIndex: [theValue : String] = [:]
    @State private var valueIndex: Int = 0
    @State var array: [theValue] = [theValue(val: "1"),
                             theValue(val: "2"),
                             theValue(val: "3")]
    
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.orange.opacity(0.4).ignoresSafeArea()
                .hueRotation(Angle(degrees: degree))
            VStack{
                ZStack(){
                    WheelView(degree: $degree, array: $array, circleSize: 300)
                        .offset(y: -100)
                        .shadow(color: .white, radius: 4, x: 0, y: 0)
                    if optionsListWithIndex.count == 0 {
                        VStack {
                            Text("No data is available.")
                            Text("Add some below")
                        }
                        .frame(width: 200, height: 200, alignment: .center)
                        .foregroundColor(Color.primary)
                        .offset(y: -100)
                    }
                    
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
                        optionsListWithIndex[theValue(val: "\(valueIndex)")] = textOption
                    }) {
                        Label("Add option", systemImage: "plus")
                            .font(.system(size: 15))
                    }
                    .padding(8)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    Spacer(minLength: 20.0)
                }
                
                
                ForEach(Array(optionsListWithIndex.values).sorted(), id: \.self){ textValue in
                    VStack(){
                        HStack(){
                            Text(findKeyForValue(value: textValue, dictionary: optionsListWithIndex) ?? "")
                            Text(textValue)
                                .font(.system(.body))
                            
                        }
                        Divider()
                    }
                    
                }
                
                
            }
            
        }
    }
    
    func findKeyForValue(value: String, dictionary: [theValue: String]) ->String?
    {
        print(Array(optionsListWithIndex.values))
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

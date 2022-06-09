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
    @State var chosenIndex: Int = 0
    @State private var showAlert = false
    @State private var showingResult = false
    @State private var result = ""
    
    var body: some View {
        NavigationView {
            ZStack() {
                Color.orange.opacity(0.4).ignoresSafeArea()
                    .hueRotation(Angle(degrees: degree))
                VStack(alignment: .center, spacing: 10){
                    Spacer()
                        .frame(height: 100)
                    ZStack(){
                        WheelView(degree: $degree, array: $arrayIndeks, circleSize: UIScreen.main.bounds.width/1.25)
                            .offset(y: -60)
                            .shadow(color: .white, radius: 4, x: 0, y: 0)
                        Triangle()
                            .fill(.red)
                            .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.height / 14, alignment: .trailing)
                            .offset(x:60, y: UIScreen.main.bounds.width/2.3)
                            .rotationEffect(.degrees(-90))

                        Button {
                            if arrayIndeks.count != 0 {
                                moveWheel()
                                //                        }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                    showAlert = true
                                    showingResult = true
                                }
                                
                                
                            }
                        } label: {
                            Text(arrayIndeks.count != 0 ? "Play" : "Add data below")
                                .font(arrayIndeks.count != 0 ? .title2 : .subheadline)
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4, alignment: .center)
                        .background(.white)
                        .foregroundColor(.orange)
                        .clipShape(Circle())
                        .offset(y: -60)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Congratulations!"), message: Text("Your spouse is \(optionsListWithIndex[Int(arrayIndeks[chosenIndex].val) ?? 0] ?? "")"), dismissButton: .default(Text("OK"), action: {
                                optionsListWithIndex.removeValue(forKey: Int(arrayIndeks[chosenIndex].val) ?? 0)
                                arrayIndeks.remove(at: chosenIndex)
                                
                                if arrayIndeks.count == 0 {
                                    resetData()
                                }
                            }))
                        }
                    }
                    .popover(isPresented: $showingResult) {
                        ResultView(result: $result, optionsListWithIndex: $optionsListWithIndex, arrayIndeks: $arrayIndeks, valueIndex: $valueIndex)
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack(){
                        Spacer(minLength: 20.0)
                        Text("Option List")
                            .font(.title2)
                            .bold()
                            .frame(alignment: .leading)
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
                            arrayIndeks.append(theValue(val: "\(valueIndex)", xOffset: 0, yOffset: 0))
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
                                        .font(.body)
                                }
                                .frame(width: UIScreen.main.bounds.width - 50, alignment: .leading)
                                Divider()
                            }
                        }
                    }
                    .frame(minWidth: 300, idealWidth: 450, maxWidth: 980, minHeight: 150, idealHeight: 150, maxHeight: 180, alignment: .leading)
                }
                
            }
        }
    }
    
    func moveWheel() {
        let randomInt = Int.random(in: 0 ..< arrayIndeks.count)
        chosenIndex = randomInt
        result = "Our wheel say that \(optionsListWithIndex[Int(arrayIndeks[chosenIndex].val) ?? 0] ?? "")"
        arrayIndeks.swapAt(0, chosenIndex)
        chosenIndex = 0
        for _ in 0 ..< 100 {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.83, blendDuration: 0.5)){
                
                degree += Double((360/arrayIndeks.count))
                
            }
        }
        degree = 0
    }
    
    func resetData() {
        optionsListWithIndex.removeAll()
        arrayIndeks.removeAll()
        valueIndex = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

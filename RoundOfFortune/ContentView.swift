//
//  ContentView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/04/22.
//

import SwiftUI

// MARK: Create main view that put all views and functionality needed
struct ContentView: View {
    // STEP 1: Set initial value that will be send to the WheelView synchronously while the app runs
    @State var degree = 0.0 /// rotation value
    @State var arrayIndeks: [theValue] = [] /// option index
    
    // STEP 2: Set initial value that will be used to control and respond to the flow of data and changes within the app
    @State private var optionsListWithIndex: [Int : String] = [:] /// key-value for the option list with the index to be displayed
    @State private var valueIndex: Int = 0 /// temporary Index
    @State var chosenIndex: Int = 0
    @State private var textOption: String = "" /// temporary variable to store value and handle data changes in the textfield
    
    // STEP 3: Set initial value as a parameter to show the ResultView
    @State private var showAlert = false
    @State private var showingResult = false
    @State private var result = ""
    
    // STEP 4: Configure the view
    var body: some View {
        // MARK: Create view that overlays background color and all views, aligning them in both axes
        ZStack() {
            /// Set view color
            Color.orange.opacity(0.4).ignoresSafeArea()
                .hueRotation(Angle(degrees: degree))
            
            // MARK: Create view that arranges the views in vertical line
            VStack(alignment: .center, spacing: 10){
                /// Set blank space
                Spacer()
                    .frame(height: 100)
                
                // MARK: Create view that overlays WheelView, Triangle, and Circle Button
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
                
                /// Set spacer
                Spacer()
                    .frame(height: 20)
                
                // MARK: Create view that arranges label Option List and button Reset in horizontal line
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
                
                // MARK: Create view that arranges TextField and Add Option button in horizontal line
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
                        Label("Add Option", systemImage: "plus")
                            .font(.system(size: 15))
                    }
                    .padding(8)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    Spacer()
                }
                
                // MARK: Create scrollable view
                ScrollView{
                    ForEach(arrayIndeks, id: \.self) { indeks in
                        /// Set the option list displayed in vertical line
                        VStack{
                            /// Set the elemen of each list displayed in horizontal line
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
    
    // STEP 5: Create function to animate the circle view when the play button is tapped
    func moveWheel() {
        let randomInt = Int.random(in: 0 ..< arrayIndeks.count)
        chosenIndex = randomInt
        result = "Our wheel say that \(optionsListWithIndex[Int(arrayIndeks[chosenIndex].val) ?? 0] ?? "")"
        arrayIndeks.swapAt(0, chosenIndex)
        chosenIndex = 0
        for _ in 0 ..< 750 {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.83, blendDuration: 0.5)){
                
                degree += Double((360/arrayIndeks.count))
                
            }
        }
        degree = 0
    }
    
    // STEP 6: Create function to reset data before start from beginning
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

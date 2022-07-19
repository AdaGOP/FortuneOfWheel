//
//  ContentView.swift
//  RoundOfFortune
//
//  Created by khoirunnisa' rizky noor fatimah on 18/04/22.
//

import SwiftUI
import Combine

// MARK: Create main view that put all views and functionality needed
struct MainWheel: View {
    @EnvironmentObject var mainWheelViewModel: MainWheelViewModel
    
    @State var degree = 0.0 /// rotation value
    @State var optionTextFieldValue: String = ""
    @State var showingResult = false
    
    // STEP 4: Configure the view
    var body: some View {
        // MARK: Create view that overlays background color and all views, aligning them in both axes
        ZStack() {
            yellowBackground()
            
            // MARK: Create view that arranges the views in vertical line
            VStack(alignment: .center, spacing: 10){
                // MARK: Create view that overlays WheelView, Triangle, and Circle Button
                WheelViewWithComponents(
                    degree: $degree,
                    showingResult: $showingResult)
                    

                // MARK: Create view that arranges label Option List and button Reset in horizontal line
                HStack(){
                    Text("Option List")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button {
                        mainWheelViewModel.resetOption()
                    } label: {
                        Label("Reset", systemImage: "repeat")
                    }
                    .foregroundColor(.red)
                }
                
                // MARK: Create view that arranges TextField and Add Option button in horizontal line
                HStack{                    
                    TextField(
                        "Input text option here",
                        text: $optionTextFieldValue
                    )
                    .font(.system(size: 15))
                    .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        mainWheelViewModel.add(newWheelOptionString: optionTextFieldValue)
                        optionTextFieldValue = ""
                    }) {
                        Label("Add Option", systemImage: "plus")
                            .font(.system(size: 15))
                    }
                    .padding(8)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            
                }
                
                // MARK: Create scrollable view
                ScrollView{
                    ForEach(mainWheelViewModel.options) { indeks in
                        VStack{
                            HStack{
                                Text("\(indeks.name)")
                                Spacer()
                            }.padding(.leading)
                            Divider()
                        }
                    }
                }
                
                
            }.padding(.horizontal)
        }
        .popover(isPresented: $showingResult) {
            ResultView(winnerName: mainWheelViewModel.options[mainWheelViewModel.chosenIndex].name){
                //Remove
            }
        }
    }
    
    @ViewBuilder
    func yellowBackground() -> some View{
        Color
            .orange
            .opacity(0.4)
            .ignoresSafeArea()
            .hueRotation(Angle(degrees: degree))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainWheel().environmentObject(MainWheelViewModel())
    }
}



//
//class VCViewModel: ObservableObject{
//
//    @Published var users: [WheelOption] = []
//    private let network = NetworkManager()
//
//    public func fetchUser(){
//        network.prefetchOptionsData { fetchedUsers in
//            self.users = fetchedUsers
//        }
//    }
//
//    public func addUser(){
//        // Business Logic to add user to the database
//        // This might consists connection with Coredata / CloudKit / etc
//        users.addNewUser()
//    }
//}
//
//
//
//class OurRegularVC: UIViewController{
//
//    var viewModel: VCViewModel = VCViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel.fetchUser()
//        updateUI()
//    }
//
//    // View Logic
//    func onButtonTap(){
//        // Manage interactions with the view
//        if textFields.validate(){
//            viewModel.addUser()
//        }
//    }
//
//    func updateUI(){
//        // Update the UI With our Data
//    }
//}

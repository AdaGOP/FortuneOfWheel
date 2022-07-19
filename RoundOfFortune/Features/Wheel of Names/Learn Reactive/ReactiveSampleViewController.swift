//
//  ReactiveSampleViewController.swift
//  RoundOfFortune
//
//  Created by octavianus on 19/07/22.
//

import SwiftUI
import UIKit
import Combine

class ReactiveSampleViewModel: ObservableObject{
    
    @Published var users: [String] = []
    private let network = NetworkManager()
    
    public func fetchUser(){
        network.prefetchOptionsData { fetchedUsers in
            self.users = fetchedUsers.map { $0.name }
        }
    }
    
    public func addUser(with newUser: String){
        // Business Logic to add user to the database
        // This might consists connection with Coredata / CloudKit / etc
        users.append(newUser)
    }
    
}


class ReactiveSampleViewController: UIViewController{
    
    let viewModel: ReactiveSampleViewModel = ReactiveSampleViewModel()
    var cancelables: Set<AnyCancellable> = []
    
    //View
    lazy var textfield: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = .gray
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Input any text"
        return tf
    }()
    
    lazy var mainLabel: UILabel = {
        var mlbl = UILabel()
        mlbl.backgroundColor = .yellow
        mlbl.translatesAutoresizingMaskIntoConstraints = false
        mlbl.textAlignment = .center
        mlbl.numberOfLines = 0
        return mlbl
    }()
    
    lazy var addBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onButtonTap)))
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindingUI()
        viewModel.fetchUser()
    }
    
    private func setupUI(){
        view.addSubview(mainLabel)
        view.addSubview(textfield)
        view.addSubview(addBtn)
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            textfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            textfield.bottomAnchor.constraint(equalTo: addBtn.topAnchor, constant: 0),
            textfield.heightAnchor.constraint(equalToConstant: 30),
            
            addBtn.rightAnchor.constraint(equalTo: textfield.rightAnchor, constant: -5),
            addBtn.bottomAnchor.constraint(equalTo: mainLabel.topAnchor,constant: 0)
        ])
    }
    
    private func setupBindingUI(){
        viewModel.$users.sink { newUsers in
            self.updateUI(with: newUsers)
        }.store(in: &cancelables)
    }
    
    
    // View Logic
    @objc func onButtonTap(){
        // Manage interactions with the view
        viewModel.addUser(with: textfield.text ?? "")
        textfield.resignFirstResponder()
        textfield.text?.removeAll()
    }
    
    private func updateUI(with strings: [String]){
        mainLabel.text = "\(strings)"
    }

}








struct ReactiveSampleView: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let initialView = ReactiveSampleViewController()
        return initialView
    }
}

struct ReactiveSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ReactiveSampleView()
    }
}



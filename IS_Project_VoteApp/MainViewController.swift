//
//  MainViewController.swift
//  IS_Project
//
//  Created by 변상우 on 5/30/24.
//

import UIKit

class MainViewController: UIViewController {

    let nameTextField = UITextField()
    let ssnTextField = UITextField()
    let nextButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Enter Details"
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .black
        
        nameTextField.placeholder = "Enter your name"
        ssnTextField.placeholder = "Enter your SSN"
        ssnTextField.keyboardType = .numberPad
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField, ssnTextField, nextButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func nextButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let ssn = ssnTextField.text, !ssn.isEmpty else {
            // Handle error: show alert
            return
        }
        
        let voteVC = VoteViewController()
        voteVC.name = name
        voteVC.ssn = ssn
        navigationController?.pushViewController(voteVC, animated: true)
    }
}

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
        view.backgroundColor = .systemGray6
        
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
        
        // C++ Encryptor 클래스 사용하여 데이터 암호화
        let encryptor = EncryptorWrapper()
        let encryptedName = encryptor?.encrypt(name)
        let encryptedSSN = encryptor?.encrypt(ssn)
        
        let voteVC = VoteViewController()
        voteVC.name = encryptedName
        voteVC.ssn = encryptedSSN
        navigationController?.pushViewController(voteVC, animated: true)
    }
}

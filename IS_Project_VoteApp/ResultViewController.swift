//
//  ResultViewController.swift
//  IS_Project
//
//  Created by 변상우 on 4/30/24.
//

import UIKit

class ResultViewController: UIViewController {
    
    var name: String!
    var ssn: String!
    var candidate: String!
    
    var candidates: [String] = ["Candidate A", "Candidate B", "Candidate C"]
    var votes: [String: Int] = [:]
    let resultLabel = UILabel()
    var serverURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Result"
        setupUI()
        fetchResult()
    }
    
    func setupUI() {
        view.backgroundColor = .systemGray6
        
        resultLabel.numberOfLines = 0
        view.addSubview(resultLabel)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            resultLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        // 뒤로가기 버튼 추가
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    func fetchResult() {
        guard let url = URL(string: "http://127.0.0.1:5000/result") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching result: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Int]
                if let result = result {
                    DispatchQueue.main.async {
                        self.updateUI(with: result)
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }.resume()
    }
    
    func updateUI(with result: [String: Int]) {
        self.votes = result
        var resultText = "Name: \(name!)\nSSN: \(ssn!)\n\nYou voted for: \(candidate!)\n\nCurrent Votes:\n\n"
        for candidate in candidates {
            if let voteCount = votes[candidate] {
                resultText += "\(candidate): \(voteCount)\n"
            } else {
                resultText += "\(candidate): 0\n"
            }
        }
        
        resultLabel.text = resultText
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


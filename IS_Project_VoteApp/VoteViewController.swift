//
//  VoteViewController.swift
//  IS_Project
//
//  Created by 변상우 on 4/30/24.
//

import UIKit

class VoteViewController: UIViewController {
    
    // 투표할 후보자 목록
    let candidates = ["Candidate A", "Candidate B", "Candidate C"]
    
    var name: String!
    var ssn: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Vote"
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .systemGray6
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        for candidate in candidates {
            let button = UIButton(type: .system)
            button.setTitle(candidate, for: .normal)
            button.addTarget(self, action: #selector(voteButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc func voteButtonTapped(_ sender: UIButton) {
        guard let candidate = sender.currentTitle else { return }
        
        // 투표 API 호출
        vote(candidate: candidate)
    }
    
    func vote(candidate: String) {
        let urlString = "http://127.0.0.1:5000/vote"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["candidate": candidate]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        URLSession.shared.uploadTask(with: request, from: jsonData) { _, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                print("Vote successfully recorded for \(candidate)")
                DispatchQueue.main.async {
                    let resultVC = ResultViewController()
                    resultVC.name = self.name
                    resultVC.ssn = self.ssn
                    resultVC.candidate = candidate
                    self.navigationController?.pushViewController(resultVC, animated: true)
                }
            } else {
                print("Error: Invalid response")
            }
        }.resume()
    }
}

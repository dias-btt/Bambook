//
//  ProfileViewController.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol?
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter?.viewDidLoad()
    }
    
    func displayProfileData(_ profileEntity: ProfileEntity) {
        usernameLabel.text = profileEntity.username
        bioLabel.text = profileEntity.bio
    }
    
    private func setupUI() {
        view.addSubview(usernameLabel)
        view.addSubview(bioLabel)
        
        usernameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
            
        bioLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(usernameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}

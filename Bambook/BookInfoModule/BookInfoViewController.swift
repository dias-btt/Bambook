//
//  BookInfoViewController.swift
//  Bambook
//
//  Created by Диас Сайынов on 19.01.2024.
//

import UIKit

class BookInfoViewController: UIViewController, BookInfoViewProtocol {

    var presenter: BookInfoPresenterProtocol?
    
    private let titleLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
           label.numberOfLines = 0
           return label
       }()

       private let descriptionLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 16)
           label.numberOfLines = 0
           return label
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-20)
        }

        presenter?.viewDidLoad()
    }
    
    func displayBookInfo(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}

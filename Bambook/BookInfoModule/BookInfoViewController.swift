//
//  BookInfoViewController.swift
//  Bambook
//
//  Created by Диас Сайынов on 19.01.2024.
//

import UIKit
import SnapKit

class BookInfoViewController: UIViewController, BookInfoViewProtocol {
    
    var presenter: BookInfoPresenterProtocol?
    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
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
        view.addSubview(bookImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        bookImageView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(150)

        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(bookImageView.snp.trailing).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(bookImageView.snp.trailing).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)

        }

        presenter?.viewDidLoad()
    }
    
    func displayBookInfo(title: String, description: String, imageURL: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        
        let url = URL(string: imageURL)
        bookImageView.sd_setImage(with: url, completed: nil)
    }
}

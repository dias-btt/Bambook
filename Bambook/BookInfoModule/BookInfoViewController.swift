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
        label.textAlignment = .center
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let ratingView = StarRatingView()
    
    private let ratingCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let readButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupViews()
        applyConstraints()

        presenter?.viewDidLoad()
    }
    
    func setupViews(){
        view.addSubview(bookImageView)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(ratingView)
        view.addSubview(ratingCount)
        view.addSubview(readButton)
        view.addSubview(shareButton)
        view.addSubview(descriptionLabel)
    }
    
    func applyConstraints(){
        bookImageView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(400)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        ratingView.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(30)
        }
        
        ratingCount.snp.makeConstraints {
            $0.top.equalTo(ratingView.snp.bottom).offset(5)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        readButton.snp.makeConstraints {
            $0.top.equalTo(ratingCount.snp.bottom).offset(20)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(readButton.snp.bottom).offset(10)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    func displayBookInfo(book: BookData) {
        titleLabel.text = book.title
        descriptionLabel.text = book.description
        authorLabel.text = book.authors[0]
        ratingView.setRating(book.averageRating)
        ratingCount.text = "\(book.ratingsCount) Ratings"
        
        let url = URL(string: book.thumbnail)
        bookImageView.sd_setImage(with: url, completed: nil)
    }
}

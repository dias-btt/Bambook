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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
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
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let readMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(readMoreButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        setupViews()
        applyConstraints()

        presenter?.viewDidLoad()
        updateDescriptionLabel()
    }
    
    func setupViews() {
        view.addSubview(scrollView)

        scrollView.addSubview(scrollStackViewContainer)
        
        scrollStackViewContainer.addSubview(bookImageView)
        scrollStackViewContainer.addSubview(titleLabel)
        scrollStackViewContainer.addSubview(authorLabel)
        scrollStackViewContainer.addSubview(ratingView)
        scrollStackViewContainer.addSubview(ratingCount)
        scrollStackViewContainer.addSubview(readButton)
        scrollStackViewContainer.addSubview(shareButton)
        scrollStackViewContainer.addSubview(saveButton)
        scrollStackViewContainer.addSubview(dividerLine)
        scrollStackViewContainer.addSubview(descriptionLabel)
        scrollStackViewContainer.addSubview(readMoreButton)

    }
    
    func applyConstraints(){
        scrollView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollStackViewContainer.snp.makeConstraints {
            $0.leading.equalTo(scrollView.snp.leading)
            $0.trailing.equalTo(scrollView.snp.trailing)
            $0.top.equalTo(scrollView.snp.top)
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        bookImageView.snp.makeConstraints {
            $0.leading.equalTo(scrollStackViewContainer).offset(20)
            $0.top.equalTo(scrollStackViewContainer).offset(20)
            $0.centerX.equalTo(scrollStackViewContainer)
            $0.height.equalTo(400)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(scrollStackViewContainer)
            $0.leading.trailing.equalTo(scrollStackViewContainer).inset(20)
        }

        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(scrollStackViewContainer)
            $0.leading.trailing.equalTo(scrollStackViewContainer).inset(20)
        }

        ratingView.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(20)
            $0.leading.equalTo(scrollStackViewContainer).offset(20)
            $0.height.equalTo(30)
        }

        ratingCount.snp.makeConstraints {
            $0.top.equalTo(ratingView.snp.bottom).offset(5)
            $0.leading.equalTo(scrollStackViewContainer).offset(20)
        }

        readButton.snp.makeConstraints {
            $0.top.equalTo(ratingCount.snp.bottom).offset(20)
            $0.centerX.equalTo(scrollStackViewContainer)
            $0.leading.trailing.equalTo(scrollStackViewContainer).inset(20)
        }

        saveButton.snp.makeConstraints {
            $0.top.equalTo(readButton.snp.bottom).offset(10)
            $0.leading.equalTo(scrollStackViewContainer).offset(20)
        }

        shareButton.snp.makeConstraints {
            $0.top.equalTo(readButton.snp.bottom).offset(10)
            $0.leading.equalTo(saveButton.snp.trailing).offset(10)
            $0.trailing.equalTo(scrollStackViewContainer).offset(-20)
            $0.width.equalTo(saveButton.snp.width)
        }

        dividerLine.snp.makeConstraints {
            $0.top.equalTo(shareButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(scrollStackViewContainer).inset(10)
            $0.height.equalTo(1)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(dividerLine.snp.bottom).offset(20)
            $0.leading.equalTo(scrollStackViewContainer).offset(20)
            $0.trailing.equalTo(scrollStackViewContainer).offset(-20)
        }
        
        readMoreButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.equalTo(scrollStackViewContainer).offset(20)
            $0.bottom.lessThanOrEqualTo(scrollStackViewContainer).offset(-20)
        }

    }
    
    @objc private func readMoreButtonTapped() {
        isExpanded.toggle()
        updateDescriptionLabel()
    }
    
    private func updateDescriptionLabel() {
        if isExpanded {
            descriptionLabel.numberOfLines = 0
            readMoreButton.setTitle("Read Less", for: .normal)
        } else {
            descriptionLabel.numberOfLines = 3
            readMoreButton.setTitle("Read More", for: .normal)
        }
    }
    
    @objc private func readButtonTapped() {
        // Call the method in the presenter to initiate navigation
        presenter?.readButtonTapped()
    }

    
    func displayBookInfo(book: BookData) {
        titleLabel.text = book.title
        descriptionLabel.text = book.description
        if descriptionLabel.text?.count ?? "".count < 250{
            readMoreButton.isHidden = true
        }
        authorLabel.text = book.authors[0]
        ratingView.setRating(book.averageRating)
        ratingCount.text = "\(book.ratingsCount) Ratings"
        
        let url = URL(string: book.thumbnail)
        bookImageView.sd_setImage(with: url, completed: nil)
    }
}

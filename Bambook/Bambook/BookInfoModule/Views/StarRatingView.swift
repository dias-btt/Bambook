//
//  StarRatingView.swift
//  Bambook
//
//  Created by Диас Сайынов on 23.01.2024.
//

import UIKit

class StarRatingView: UIView {
    private let starImageViews: [UIImageView] = {
        var imageViews: [UIImageView] = []
        for _ in 0..<5 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(systemName: "star.fill")
            imageView.tintColor = .white
            imageViews.append(imageView)
        }
        return imageViews
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
        for starImageView in starImageViews {
            addSubview(starImageView)
        }

        // Set up constraints for starImageViews
        for (index, starImageView) in starImageViews.enumerated() {
            starImageView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(index * 20)
                $0.width.height.equalTo(20) // Adjust the size of the stars as needed
            }
        }
    }

    func setRating(_ rating: Double) {
        let fullStars = Int(rating)
        let halfStar = rating - Double(fullStars)

        for (index, starImageView) in starImageViews.enumerated() {
            if index < fullStars {
                starImageView.tintColor = .white
            } else if index == fullStars && halfStar > 0 {
                starImageView.image = UIImage(systemName: "star.leadinghalf.fill")
                starImageView.tintColor = .white
            } else {
                starImageView.image = UIImage(systemName: "star")
                starImageView.tintColor = .white
            }
        }
    }
}

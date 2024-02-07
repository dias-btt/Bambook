//
//  HeaderUIView.swift
//  Bambook
//
//  Created by Диас Сайынов on 17.01.2024.
//

import UIKit
import SnapKit

class HeaderUIView: UIView {
    var presenter: FeedPresenterProtocol?
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor(red: 0.93, green: 0.36, blue: 0.36, alpha: 1.00)
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let saveImage: UIImageView = {
       let saveImage = UIImageView()
        saveImage.image = UIImage(named: "save")
        return saveImage
    }()
    
    private let saveTitle: UILabel = {
       let saveTitle = UILabel()
        saveTitle.text = "Add to list"
        saveTitle.textColor = .white
        saveTitle.font = .boldSystemFont(ofSize: 13)
        return saveTitle
    }()

    private let readButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let playImage: UIImageView = {
       let playImage = UIImageView()
        playImage.image = UIImage(named: "play")
        return playImage
    }()
    
    private let readTitle: UILabel = {
       let readTitle = UILabel()
        readTitle.text = "Read"
        readTitle.textColor = .black
        readTitle.font = .boldSystemFont(ofSize: 13)
        return readTitle
    }()

    private let topRecommendationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "topRecommendation")?.withRoundedCorners(radius: 22)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topRecommendationImage)
                
        addSubview(readButton)
        readButton.addSubview(playImage)
        readButton.addSubview(readTitle)
        
        addSubview(saveButton)
        saveButton.addSubview(saveImage)
        saveButton.addSubview(saveTitle)
        applyConstraints()
    }

    private func applyConstraints() {
        readButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(90)
            $0.bottom.equalToSuperview().offset(-50)
            $0.width.equalTo(100)
        }
        
        playImage.snp.makeConstraints {
            $0.leading.equalTo(readButton.snp.leading).offset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(15)
        }

        readTitle.snp.makeConstraints {
            $0.leading.equalTo(playImage.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }

        saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-90)
            $0.bottom.equalToSuperview().offset(-50)
            $0.width.equalTo(100)
        }
        
        saveImage.snp.makeConstraints {
            $0.leading.equalTo(saveButton.snp.leading).offset(10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(15)
        }

        saveTitle.snp.makeConstraints {
            $0.leading.equalTo(saveImage.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        topRecommendationImage.frame = CGRect(x: (bounds.width - 250) / 2, y: 0, width: 250, height: 400)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc private func readButtonTapped() {
        presenter?.readButtonTapped()
    }
}

extension UIImage {
    // image with rounded corners
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

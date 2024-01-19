//
//  HeaderUIView.swift
//  Bambook
//
//  Created by Диас Сайынов on 17.01.2024.
//

import UIKit
import SnapKit

class HeaderUIView: UIView{
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let readButton: UIButton = {
        let button = UIButton()
        button.setTitle("Read", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let topRecommendationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "topRecommendation")
        return imageView
    }()
    
    private func addGradient(){
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topRecommendationImage)
        addGradient()
        addSubview(readButton)
        addSubview(saveButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        readButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(90)
            $0.bottom.equalToSuperview().offset(-50)
            $0.width.equalTo(100)
        }
        
        saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-90)
            $0.bottom.equalToSuperview().offset(-50)
            $0.width.equalTo(100)
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        topRecommendationImage.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

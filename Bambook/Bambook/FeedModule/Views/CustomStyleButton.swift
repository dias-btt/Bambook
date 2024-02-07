//
//  CustomStyleButton.swift
//  Bambook
//
//  Created by Диас Сайынов on 06.02.2024.
//
import UIKit

class CustomStyledButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
    }

    private func configureButton() {
        layer.cornerRadius = 15
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        titleEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

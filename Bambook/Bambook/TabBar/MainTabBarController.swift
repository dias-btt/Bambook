//
//  MainTabBarController.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import UIKit

open class MainTabBarController: UITabBarController {
    public override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)

        // TODO: use common colors
        tabBar.tintColor = UIColor(red: 7 / 255, green: 176 / 255, blue: 250 / 255, alpha: 1)
        tabBar.backgroundColor = .systemBackground
    }
}

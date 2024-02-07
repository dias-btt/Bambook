//
//  TabBarRouter.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import UIKit

public protocol TabBarRouterProtocol {
    var viewController: UITabBarController? { get set }
    static func build() -> UIViewController
}

class TabBarRouter: TabBarRouterProtocol {
    weak public var viewController: UITabBarController?

    init(viewController: MainTabBarController) {
        self.viewController = viewController
    }

    public static func build() -> UIViewController {
        let view = MainTabBarController()
        let profileVC = ProfileRouter.createModule()
        let feedVC = FeedRouter.createModule()

        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.circle.fill"),
            tag: 1
        )
        
        feedVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )

        let controllers = [feedVC, profileVC]

        view.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }

        let router = TabBarRouter(viewController: view)
        router.viewController = view

        return view
    }

}

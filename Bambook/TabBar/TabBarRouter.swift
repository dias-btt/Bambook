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
            title: "Профиль",
            image: UIImage(systemName: "person.circle.fill"),
            tag: 4
        )
        
        feedVC.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "person.circle.fill"),
            tag: 4
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

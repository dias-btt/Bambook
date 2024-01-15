//
//  ProfileRouter.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import UIKit

public class ProfileRouter: ProfileWireframeProtocol {
    weak var viewController: UIViewController?

    public static func createModule() -> UIViewController {
        let view = ProfileViewController()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        let presenter = ProfilePresenter(
            view: view,
            interactor: interactor,
            router: router
        )

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}


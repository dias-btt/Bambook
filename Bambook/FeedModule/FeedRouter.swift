//
//  ProfileRouter.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import UIKit

public class FeedRouter: FeedWireframeProtocol {
    weak var viewController: UIViewController?

    public static func createModule() -> UIViewController {
        let view = FeedViewController()
        let interactor = FeedInteractor()
        let router = FeedRouter()
        let presenter = FeedPresenter(
            view: view,
            interactor: interactor,
            router: router
        )

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
                
        return view
    }
    
    public func navigateToBookInfo(with title: String, description: String, imageURL: String) {
        guard let navigationController = viewController?.navigationController else {
            return
        }
        let bookInfoModule = BookInfoRouter.createModule(title: title, description: description, imageURL: imageURL)
        navigationController.pushViewController(bookInfoModule, animated: true)
    }
}

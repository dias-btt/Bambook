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
    
    public func navigateToBookInfo(book: BookData) {
        guard let navigationController = viewController?.navigationController else {
            return
        }
        let bookInfoModule = BookInfoRouter.createModule(book: book)
        navigationController.pushViewController(bookInfoModule, animated: true)
    }
}

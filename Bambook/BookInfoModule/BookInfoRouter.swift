//
//  BookInfoRouter.swift
//  Bambook
//
//  Created by Диас Сайынов on 19.01.2024.
//

import UIKit

class BookInfoRouter: BookInfoWireframeProtocol {

    weak var viewController: UIViewController?

    public static func createModule(title: String, description: String, imageURL: String) -> UIViewController {
        let view = BookInfoViewController()
        let interactor = BookInfoInteractor()
        let router = BookInfoRouter()
        let presenter = BookInfoPresenter(
            view: view,
            interactor: interactor,
            router: router,
            title: title,
            description: description,
            imageURL: imageURL
        )

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        presenter.viewDidLoad()

        return view
    }
}

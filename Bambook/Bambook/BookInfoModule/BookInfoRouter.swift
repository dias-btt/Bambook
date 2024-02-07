//
//  BookInfoRouter.swift
//  Bambook
//
//  Created by Диас Сайынов on 19.01.2024.
//

import UIKit

class BookInfoRouter: BookInfoWireframeProtocol {

    weak var viewController: UIViewController?

    public static func createModule(book: BookData) -> UIViewController {
        let view = BookInfoViewController()
        let interactor = BookInfoInteractor()
        let router = BookInfoRouter()
        let presenter = BookInfoPresenter(
            view: view,
            interactor: interactor,
            router: router,
            book: book
        )

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        presenter.viewDidLoad()
        
        return view
    }
    
    func navigateToRead(book: BookData) {
        guard let navigationController = viewController?.navigationController else {
            return
        }
        let readModule = ReadRouter.createModule(book: book)
        navigationController.pushViewController(readModule, animated: true)
    }
}

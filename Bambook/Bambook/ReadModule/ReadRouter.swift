//
//  ReadRouter.swift
//  Bambook
//
//  Created by Диас Сайынов on 24.01.2024.
//

import UIKit

class ReadRouter: ReadWireframeProtocol {

    weak var viewController: UIViewController?

    public static func createModule(book: BookData) -> UIViewController {
        let view = ReadViewController()
        let interactor = ReadInteractor()
        let router = ReadRouter()
        let presenter = ReadPresenter(
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
}

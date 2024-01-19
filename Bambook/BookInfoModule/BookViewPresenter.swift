//
//  BookViewPresenter.swift
//  Bambook
//
//  Created by Диас Сайынов on 19.01.2024.
//

import Foundation

class BookInfoPresenter: BookInfoPresenterProtocol {
    weak var view: BookInfoViewProtocol?
    var interactor: BookInfoInteractorProtocol?
    var router: BookInfoWireframeProtocol?
    var title: String
    var description: String

    init(view: BookInfoViewProtocol, interactor: BookInfoInteractorProtocol, router: BookInfoWireframeProtocol, title: String, description: String) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.title = title
        self.description = description
    }
    
    func viewDidLoad(){
        view?.displayBookInfo(title: title, description: description)
    }
}

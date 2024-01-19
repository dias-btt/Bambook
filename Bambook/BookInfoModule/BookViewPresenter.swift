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
    var imageURL: String

    init(view: BookInfoViewProtocol, interactor: BookInfoInteractorProtocol, router: BookInfoWireframeProtocol, title: String, description: String, imageURL: String) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
    
    func viewDidLoad(){
        view?.displayBookInfo(title: title, description: description, imageURL: imageURL)
    }
}

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
    var book: BookData?

    init(view: BookInfoViewProtocol, interactor: BookInfoInteractorProtocol, router: BookInfoWireframeProtocol, book: BookData) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.book = book
    }
    
    func viewDidLoad(){
        guard let book = self.book else {return}
        view?.displayBookInfo(book: book)
    }
}

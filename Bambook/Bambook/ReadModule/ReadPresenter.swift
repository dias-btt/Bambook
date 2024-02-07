//
//  ReadPresenter.swift
//  Bambook
//
//  Created by Диас Сайынов on 24.01.2024.
//

import Foundation

class ReadPresenter: ReadPresenterProtocol {
    weak var view: ReadViewProtocol?
    var interactor: ReadInteractorProtocol?
    var router: ReadWireframeProtocol?
    var book: BookData?

    init(view: ReadViewProtocol, interactor: ReadInteractorProtocol, router: ReadWireframeProtocol, book: BookData) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.book = book
    }
    
    func viewDidLoad(){
        guard let book = self.book else {return}
    }
}

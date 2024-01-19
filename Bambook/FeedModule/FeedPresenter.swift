//
//  ProfilePresenter.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import UIKit

final class FeedPresenter: FeedPresenterProtocol {
    weak var view: FeedViewProtocol?
    var interactor: FeedInteractorProtocol?
    var router: FeedWireframeProtocol?
    var books: [BookData] = []

    init(view: FeedViewProtocol, interactor: FeedInteractorProtocol, router: FeedWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor?.fetchFeedData(completion: { [weak self] jsonData in
            guard let jsonData = jsonData else {
                return
            }
            self?.books = self?.interactor?.parseBooks(jsonData: jsonData) ?? []
            self?.view?.reloadData()
        })
    }
    
    func getPopularBooks() -> [BookData]{
        let sortedBooks = self.books.sorted { $0.ratingsCount > $1.ratingsCount }
        let top10Books = Array(sortedBooks.prefix(10))
        return top10Books
    }
    
    func didSelectTitleSection(book: BookData) {
        router?.navigateToBookInfo(with: book.title, description: book.description)
    }

}

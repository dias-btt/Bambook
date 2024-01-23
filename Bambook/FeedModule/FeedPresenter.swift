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
        interactor?.fetchFeedData(forUser: MockUser.MOCK_USERS[0], completion: { [weak self] books in
            guard let books = books else {
                return
            }
            self?.books = books
            self?.view?.reloadData()
        })
    }
    
    func getPopularBooks() -> [BookData]{
        let sortedBooks = self.books.sorted { $0.ratingsCount > $1.ratingsCount }
        let top10Books = Array(sortedBooks.prefix(10))
        return top10Books
    }
    
    func getRecommendationBooks() -> [BookData]{
        return [
            BookData(title: "Rec1", authors: ["DS"], averageRating: 4.0, ratingsCount: 200, thumbnail: "", description: ""),
            BookData(title: "Rec2", authors: ["DS"], averageRating: 4.0, ratingsCount: 200, thumbnail: "", description: ""),
            BookData(title: "Rec3", authors: ["DS"], averageRating: 4.0, ratingsCount: 200, thumbnail: "", description: ""),
            BookData(title: "Rec4", authors: ["DS"], averageRating: 4.0, ratingsCount: 200, thumbnail: "", description: ""),
        ]
    }
    
    func didSelectTitleSection(book: BookData) {
        router?.navigateToBookInfo(book: book)
    }
}

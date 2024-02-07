//
//  FeedProtocols.swift
//  Bambook
//
//  Created by Диас Сайынов on 11.01.2024.
//

import Foundation

public protocol FeedWireframeProtocol: AnyObject {
    func navigateToBookInfo(book: BookData)
    func navigateToRead(book: BookData)
}

protocol CollectionViewProtocol: AnyObject {
    var presenter: FeedPresenterProtocol? { get set }
}

protocol FeedViewProtocol: AnyObject {
    var presenter: FeedPresenterProtocol? { get set }
    var books: [BookData]? {get set}
    func reloadData()
}

protocol FeedInteractorProtocol: AnyObject {
    var presenter: FeedPresenterProtocol? { get set }
    func fetchFeedData(forUser user: MockUser, completion: @escaping ([BookData]?) -> Void)
    func fetchBooks(forQuery query: String, completion: @escaping (Data?) -> Void)
    func parseBooks(jsonData: Data) -> [BookData]?
}
protocol FeedPresenterProtocol: AnyObject {
    func viewDidLoad()
    func readButtonTapped()
    func getPopularBooks() -> [BookData]
    func getRecommendationBooks() -> [BookData]
    func didSelectTitleSection(book: BookData)
}

//
//  FeedProtocols.swift
//  Bambook
//
//  Created by Диас Сайынов on 11.01.2024.
//

import Foundation

public protocol FeedWireframeProtocol: AnyObject {
}

protocol FeedViewProtocol: AnyObject {
    var presenter: FeedPresenterProtocol? { get set }
    func displayFeedData(_ feedEntity: FeedEntity)
}

protocol FeedInteractorProtocol: AnyObject {
    var presenter: FeedPresenterProtocol? { get set }
    func fetchFeedData()
}
protocol FeedPresenterProtocol: AnyObject {
    func viewDidLoad()
    func feedDataFetched(_ feedEntity: FeedEntity)
}

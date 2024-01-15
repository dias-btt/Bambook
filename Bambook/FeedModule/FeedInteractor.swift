//
//  FeedInteractor.swift
//  Bambook
//
//  Created by Диас Сайынов on 11.01.2024.
//

import Foundation

final class FeedInteractor {
    weak var presenter: FeedPresenterProtocol?
    // Add properties for data manager, networking, etc.

    init(presenter: FeedPresenterProtocol? = nil) {
        self.presenter = presenter
    }
}

extension FeedInteractor: FeedInteractorProtocol{
    func fetchFeedData() {
        // Implement data fetching logic
        let feedData = FeedEntity(username: "JohnDoe", bio: "iOS Developer")
        presenter?.feedDataFetched(feedData)
    }
}

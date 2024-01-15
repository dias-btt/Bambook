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

    init(view: FeedViewProtocol, interactor: FeedInteractorProtocol, router: FeedWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor?.fetchFeedData()
    }

    func feedDataFetched(_ feedEntity: FeedEntity) {
        view?.displayFeedData(feedEntity)
    }
}

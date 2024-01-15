//
//  ProfilePresenter.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import UIKit

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileWireframeProtocol?

    init(view: ProfileViewProtocol, interactor: ProfileInteractorProtocol, router: ProfileWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor?.fetchProfileData()
    }

    func profileDataFetched(_ profileEntity: ProfileEntity) {
        view?.displayProfileData(profileEntity)
    }
}

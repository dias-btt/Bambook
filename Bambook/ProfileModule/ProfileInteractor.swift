//
//  ProfileInteractor.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import Foundation

final class ProfileInteractor {
    weak var presenter: ProfilePresenterProtocol?
    // Add properties for data manager, networking, etc.

    init(presenter: ProfilePresenterProtocol? = nil) {
        self.presenter = presenter
    }
}

extension ProfileInteractor: ProfileInteractorProtocol{
    func fetchProfileData() {
        // Implement data fetching logic
        let profileData = ProfileEntity(username: "JohnDoe", bio: "iOS Developer")
        presenter?.profileDataFetched(profileData)
    }
}

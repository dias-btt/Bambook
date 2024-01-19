//
//  BookInfoInteractor.swift
//  Bambook
//
//  Created by Диас Сайынов on 19.01.2024.
//

import Foundation

final class BookInfoInteractor {
    weak var presenter: BookInfoPresenterProtocol?
    // Add properties for data manager, networking, etc.

    init(presenter: BookInfoPresenterProtocol? = nil) {
        self.presenter = presenter
    }
}

extension BookInfoInteractor: BookInfoInteractorProtocol {
    
}

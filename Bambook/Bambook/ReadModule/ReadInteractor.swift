//
//  ReadInteractor.swift
//  Bambook
//
//  Created by Диас Сайынов on 24.01.2024.
//

import Foundation

final class ReadInteractor {
    weak var presenter: ReadPresenterProtocol?

    init(presenter: ReadPresenterProtocol? = nil) {
        self.presenter = presenter
    }
}

extension ReadInteractor: ReadInteractorProtocol {
    
}

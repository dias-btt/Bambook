//
//  BookInfoProtocols.swift
//  Bambook
//
//  Created by Диас Сайынов on 19.01.2024.
//

import Foundation

public protocol BookInfoWireframeProtocol: AnyObject {
    func navigateToRead(book: BookData)
}

protocol BookInfoViewProtocol: AnyObject {
    var presenter: BookInfoPresenterProtocol? { get set }
    func displayBookInfo(book: BookData)
}

protocol BookInfoInteractorProtocol: AnyObject {
    var presenter: BookInfoPresenterProtocol? { get set }
    
}
protocol BookInfoPresenterProtocol: AnyObject {
    func viewDidLoad()
    func readButtonTapped()
}

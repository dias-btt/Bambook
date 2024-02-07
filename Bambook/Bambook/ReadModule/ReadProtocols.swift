//
//  ReadProtocols.swift
//  Bambook
//
//  Created by Диас Сайынов on 24.01.2024.
//

import Foundation

public protocol ReadWireframeProtocol: AnyObject {
}

protocol ReadViewProtocol: AnyObject {
    var presenter: ReadPresenterProtocol? { get set }
}

protocol ReadInteractorProtocol: AnyObject {
    var presenter: ReadPresenterProtocol? { get set }
    
}
protocol ReadPresenterProtocol: AnyObject {
    func viewDidLoad()
}

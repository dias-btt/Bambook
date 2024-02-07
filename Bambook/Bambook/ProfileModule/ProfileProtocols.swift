//
//  ProfileProtocols.swift
//  Bambook
//
//  Created by Диас Сайынов on 10.01.2024.
//

import Foundation

public protocol ProfileWireframeProtocol: AnyObject {
}

protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func displayProfileData(_ profileEntity: ProfileEntity)
}

protocol ProfileInteractorProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func fetchProfileData()
}
protocol ProfilePresenterProtocol: AnyObject {
    func viewDidLoad()
    func profileDataFetched(_ profileEntity: ProfileEntity)
}

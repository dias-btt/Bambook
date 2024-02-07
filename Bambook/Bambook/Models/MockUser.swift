//
//  MockUser.swift
//  Bambook
//
//  Created by Диас Сайынов on 23.01.2024.
//

import Foundation

struct MockUser {
    let username: String
    let readBooks: [String]

    init(username: String, readBooks: [String]) {
        self.username = username
        self.readBooks = readBooks
    }
}

extension MockUser{
    static var MOCK_USERS: [MockUser] = [
        .init(username: "Dias Saiynov", readBooks: ["Game of Thrones", "Harry Potter", "Lord of Rings"])
    ]
}

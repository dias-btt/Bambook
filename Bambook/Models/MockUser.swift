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
        .init(username: "Dias Saiynov", readBooks: ["Moby Dick", "Harry Potter", "1Q84"])
    ]
}

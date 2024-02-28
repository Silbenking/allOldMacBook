//
//  UsersModel.swift
//  MVVM cmdB
//
//  Created by Сергей Сырбу on 01.02.2024.
//

import Foundation

struct User: Decodable {
    let name: String
    let username: String
    let email: String
    let address: Address?
    let phone: String
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
}

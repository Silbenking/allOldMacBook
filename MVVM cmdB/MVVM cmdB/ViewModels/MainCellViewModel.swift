//
//  MainCellViewModel.swift
//  MVVM cmdB
//
//  Created by Сергей Сырбу on 03.02.2024.
//

import Foundation

class MainCellViewModel {
    var name: String
    var mail: String
    
    init(_ user: User) {
        self.name = user.name
        self.mail = user.email
    }
}

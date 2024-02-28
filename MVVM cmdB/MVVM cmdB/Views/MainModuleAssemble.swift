//
//  MainModuleAssemble.swift
//  MVVM cmdB
//
//  Created by Сергей Сырбу on 02.02.2024.
//

import Foundation
import UIKit

struct MainModuleAssemble {
    static func assemble() -> UIViewController {
        let network = NetworkService()
        let mainModel = MainViewModel(networkService: network)
        let viewConrtoller = MainViewController(viewModel: mainModel)
        return viewConrtoller
    }
}

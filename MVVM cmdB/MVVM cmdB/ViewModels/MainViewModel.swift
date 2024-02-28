//
//  MainViewModel.swift
//  MVVM cmdB
//
//  Created by Сергей Сырбу on 01.02.2024.
//

import Foundation

protocol IMainViewModel {
    func getUsers()
    var dataSource: [User] {get}
    var isLoading: Observable<Bool> {get}
    func mapCellData()
    var cellDataSource: Observable<[MainCellViewModel]> {get}
}

final class MainViewModel {
    let networkService: INetworkService
    var dataSource: [User] = []
    init(networkService: INetworkService) {
        self.networkService = networkService
    }
 
    var isLoading: Observable<Bool> = Observable(value: false)
    var cellDataSource: Observable<[MainCellViewModel]> = Observable(value: nil)
}

extension MainViewModel: IMainViewModel {
    
    func mapCellData() {
        cellDataSource.value = dataSource.compactMap({ MainCellViewModel($0)
        })
    }

    func getUsers() {
        isLoading.value = true
        networkService.fetchData { [weak self] result in
            guard let self else {return}
            self.isLoading.value = false

            switch result {
            case .success(let usersData):
                self.dataSource = usersData
            case .failure(let error):
                print(error.localizedDescription)
            }
            mapCellData()
        }
    }
    
    
}

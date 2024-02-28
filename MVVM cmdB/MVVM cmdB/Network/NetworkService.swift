//
//  NetworkService.swift
//  MVVM cmdB
//
//  Created by Сергей Сырбу on 01.02.2024.
//

import Foundation

protocol INetworkService {
    func fetchData(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

final class NetworkService: INetworkService {
    func fetchData(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: EndPoint.users.url) { data, _, error in
            guard let data else {
                if let error{
                    completion(.failure(.urlError))
                    print("no data")
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let userData = try decoder.decode([User].self, from: data)
                completion(.success(userData))
            } catch {
                completion(.failure(.canNotParseDate))
            }
        } .resume()
    }
}

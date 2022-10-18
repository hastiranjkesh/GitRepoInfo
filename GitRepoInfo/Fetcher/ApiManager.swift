//
//  ApiManager.swift
//  GitRepoInfo
//
//  Created by hasti ranjkesh on 10/18/22.
//

import Foundation
import Combine

protocol ApiManagerProtocol {
    func getRepository(url: URL) -> AnyPublisher<GitRepoModel, Error>
}

final class ApiManager: ApiManagerProtocol {
    let session = URLSession.shared
    
    func getRepository(url: URL) -> AnyPublisher<GitRepoModel, Error> {
        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .decode(type: GitRepoModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

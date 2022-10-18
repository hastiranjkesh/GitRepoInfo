//
//  MockApiManager.swift
//  GitRepoInfoTests
//
//  Created by hasti ranjkesh on 10/18/22.
//

import Foundation
import Combine
@testable import GitRepoInfo

final class MockApiManager: ApiManagerProtocol {
    func getRepository(url: URL) -> AnyPublisher<GitRepoModel, Error> {
        Future { promise in
            let repo = GitRepoModel(fullName: "facebook/facebook-ios-sdk",
                                    language: "swift",
                                    forks: 3200,
                                    openIssuesCount: 40,
                                    stargazersCount: 7000,
                                    organization: RepoOrganization(avatarUrl: "https://avatars.githubusercontent.com/u/69631?v=4"))
            promise(.success(repo))
        }.eraseToAnyPublisher()
    }
}

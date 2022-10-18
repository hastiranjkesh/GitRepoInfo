//
//  GitRepoInfoTests.swift
//  GitRepoInfoTests
//
//  Created by hasti ranjkesh on 10/18/22.
//

import XCTest
import Combine
@testable import GitRepoInfo

final class GitRepoInfoTests: XCTestCase {
    
    let sut = GitRepoViewModel(apiManager: MockApiManager())
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testGetRepository() throws {
        sut.getRepository()
        guard let repo = sut.repo else {
            XCTAssertNil(sut.repo)
            return
        }
        XCTAssertEqual(repo.fullName, "facebook/facebook-ios-sdk")
        XCTAssertEqual(repo.language, "swift")
        XCTAssertEqual(repo.forks, 3200)
        XCTAssertEqual(repo.openIssuesCount, 40)
        XCTAssertEqual(repo.stargazersCount, 7000)
    }
}

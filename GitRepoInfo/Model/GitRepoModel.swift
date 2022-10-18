//
//  GitRepoModel.swift
//  GitRepoInfo
//
//  Created by hasti ranjkesh on 10/18/22.
//

import Foundation

struct GitRepoModel: Decodable {
    let fullName: String
    let language: String
    let forks: Int
    let openIssuesCount: Int
    let stargazersCount: Int
    let organization: RepoOrganization
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case language
        case forks
        case openIssuesCount = "open_issues_count"
        case stargazersCount = "stargazers_count"
        case organization
    }
}

struct RepoOrganization: Decodable {
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}

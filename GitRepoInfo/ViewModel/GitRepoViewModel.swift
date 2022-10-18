//
//  GitRepoViewModel.swift
//  GitRepoInfo
//
//  Created by hasti ranjkesh on 10/18/22.
//

import Foundation
import Combine

final class GitRepoViewModel {
    @Published var error: Error?
    @Published var isLoadingFinished: Bool = false
    private var cancellable = Set<AnyCancellable>()
    
    private var apiManager: ApiManagerProtocol
    var repo: GitRepoModel?
    
    init(apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func getRepository() {
        guard let url = URL(string: "https://github.com/facebook/facebook-ios-sdk") else {
            return
        }
        apiManager.getRepository(url: url)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    self?.isLoadingFinished = true
                }
            } receiveValue: {[weak self] repo in
                self?.repo = repo
            }
            .store(in: &cancellable)
    }
}
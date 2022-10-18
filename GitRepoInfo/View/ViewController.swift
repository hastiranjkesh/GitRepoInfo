//
//  GitRepoViewController.swift
//  GitRepoInfo
//
//  Created by hasti ranjkesh on 10/18/22.
//

import UIKit
import Combine

final class GitRepoViewController: UIViewController {
    
    private var viewModel: GitRepoViewModel
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var repoIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var forksLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var openIssuesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var starredByLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            fullNameLabel,
            languageLabel,
            forksLabel,
            openIssuesLabel,
            starredByLabel
        ])
        stack.distribution = .equalSpacing
        stack.spacing = 16
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(viewModel: GitRepoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
        
        viewModel.getRepository()
        addObservers()
    }
    
    private func addSubviews() {
        view.addSubview(repoIcon)
        view.addSubview(stackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            repoIcon.widthAnchor.constraint(equalToConstant: 220),
            repoIcon.heightAnchor.constraint(equalToConstant: 220),
            repoIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repoIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 36)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: repoIcon.bottomAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func addObservers() {
        viewModel.$isLoadingFinished
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isLoadingFinished in
                if isLoadingFinished {
                    self?.updateUI()
                }
            }
            .store(in: &cancellable)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { error in
                if let error = error {
                    print("Something went wrong! \(error.localizedDescription)")
                }
            }
            .store(in: &cancellable)
    }
    
    private func updateUI() {
        guard let repo = viewModel.repo else { return }
        repoIcon.downloadImage(from: repo.organization.avatarUrl)
        fullNameLabel.text = repo.fullName
        languageLabel.text = "Programming language: " + repo.language
        forksLabel.text = "Number of forks: \(repo.forks)"
        openIssuesLabel.text = "Number of open issues: \(repo.openIssuesCount)"
        starredByLabel.text = "Number of starred by: \(repo.stargazersCount)"
    }
}


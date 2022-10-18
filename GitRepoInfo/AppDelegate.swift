//
//  AppDelegate.swift
//  GitRepoInfo
//
//  Created by hasti ranjkesh on 10/18/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let repoViewController = GitRepoViewController(viewModel: GitRepoViewModel(apiManager: ApiManager()))
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = repoViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}


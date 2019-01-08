//
//  Navigator.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/16/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import UIKit

class Navigator {
    static let shared = Navigator()
    
    let navigationVC = MainNavigationViewController(rootViewController: HomeController())
    
    private init() {
        navigationVC.hidesBarsOnSwipe = true
        navigationVC.navigationBar.isTranslucent = false
        navigationVC.navigationBar.tintColor = UIColor.white
        navigationVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationVC
        return window
    }()
    
    func showSettingView(VC: UIViewController) {
        navigationVC.pushViewController(VC, animated: true)
    }
    
}

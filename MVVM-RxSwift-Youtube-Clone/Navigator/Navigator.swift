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
    private init() { }
    
    let navigationVC = MainNavigationViewController(rootViewController: HomeController())
    
    lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationVC
        return window
    }()
    
}

//
//  MainNavigationController.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/16/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import UIKit

final class MainNavigationViewController: UINavigationController {
    let statusBarBackgroundView = UIView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        visualize()
    }
    
    func setupView() {
        view.addSubview(statusBarBackgroundView)
    }
    
    func visualize() {
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.barTintColor = Color.appMain
        
        statusBarBackgroundView.backgroundColor = Color.statusBackground
        view.addConstraintsWithFormat("H:|[v0]|", views: statusBarBackgroundView)
        let height = UIApplication.shared.statusBarFrame.height
        view.addConstraintsWithFormat("V:|[v0(\(height))]", views: statusBarBackgroundView)
    }
}

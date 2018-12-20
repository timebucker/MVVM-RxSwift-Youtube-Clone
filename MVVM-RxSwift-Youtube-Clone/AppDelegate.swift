//
//  AppDelegate.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/16/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let provider = APIProvider.default
        
        provider.request(.getVideoList(categoryId: "10")) { [weak self] event in
            switch event {
            case let .success(response):
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data, options: []) as! [String: AnyObject]
                    print(json)
                }
                catch {
                    
                }
            case .failure(_):
                break
            }
        }
        
        window = Navigator.shared.window
        window?.makeKeyAndVisible()
        return true
    }
}


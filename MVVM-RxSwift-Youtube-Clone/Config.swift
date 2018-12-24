//
//  Config.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/21/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import Foundation

final class Config {
    let APIKey = "AIzaSyCgmFidZgSejS7od9Z0ASjnIkOLfJXMbEY"
    let baseURL = "https://www.googleapis.com/youtube/v3"
    
    var paramDefault: [String: Any] {
        return [
            "part": "snippet",
            "key": self.APIKey
        ]
    }
    
    static let shared = Config()
    
    private init(){
        
    }
}

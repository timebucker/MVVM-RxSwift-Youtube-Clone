//
//  Api.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/18/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import Foundation
import Moya
import MoyaSugar

enum VideoAPI: SugarTargetType {
    case getVideoList(categoryId: String)
}

extension VideoAPI {
    public var baseURL: URL {
        return URL(string: Config.shared.baseURL)!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
}


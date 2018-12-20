//
//  APIProvider.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/21/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import Moya
import MoyaSugar
import Alamofire

final class APIProvider: MoyaProvider<VideoAPI> {
    static let `default` = APIProvider()
    
    private init() {
        
    }
}

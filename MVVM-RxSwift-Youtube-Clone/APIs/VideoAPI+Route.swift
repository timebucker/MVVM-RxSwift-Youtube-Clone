//
//  VideoAPI+Route.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/21/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import Foundation
import MoyaSugar

extension VideoAPI {
    var route: Route {
        switch self {
        case .getVideoList:
            return .get("/search")
        case .getChannelInfo:
            return .get("/channels")
        }
    }
}

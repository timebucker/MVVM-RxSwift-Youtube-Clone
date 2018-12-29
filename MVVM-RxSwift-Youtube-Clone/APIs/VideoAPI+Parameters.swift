//
//  VideoAPI+Parameters.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/21/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import Foundation
import Moya
import MoyaSugar

extension VideoAPI {
    var parameters: Parameters? {
        var parameter = Config.shared.paramDefault
        let encode = URLEncoding.methodDependent
        switch self {
        case .getVideoList(let categoryId):
            parameter["videoCategoryId"] = categoryId
            parameter["type"] = "video"
            parameter["maxResults"] = 5
        case .getChannelInfo(let channelId):
            parameter["id"] = channelId
        case .getTrendingVideos:
            parameter["chart"] = "mostPopular"
        default:
            break
        }
    
        return Parameters(encoding: encode, values: parameter)
    }
}

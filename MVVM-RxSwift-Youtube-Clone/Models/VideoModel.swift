//
//  VideoModel.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/19/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import Foundation

class VideoModel {
    let videoId: String?
    let videoURL: String?
    let thumbnailURL: String?
    let viewCount: Double
    let channelName: String?
    let channelAvatarURL: String?

    init() {
        videoId = ""
        videoURL = ""
        thumbnailURL = ""
        viewCount = 0
        channelName = ""
        channelAvatarURL = ""
    }
}


//
//  VideoModel.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/19/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import Foundation

class VideoModel {
    var videoId: String?
    var videoURL: String?
    var title: String?
    var thumbnailURL: String?
    var viewCount: Double
    var channelName: String?
    var channelId: String?
    var channelAvatarURL: String?

    init() {
        videoId = ""
        videoURL = ""
        title = ""
        channelId = ""
        thumbnailURL = ""
        viewCount = 0
        channelName = ""
        channelAvatarURL = ""
    }
}


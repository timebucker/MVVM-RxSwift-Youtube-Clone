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
    
//    init(id: String, url: String, title: String, thumbnail: String, viewCount: Double, channelName: String, channelAvatar: String) {
//        videoId = id
//        videoURL = "https://www.youtube.com/watch?v=\(String(describing: videoId))"
//        title = title
//        thumbnailURL = thumbnail
//        viewCount = viewCount
//        channelName = channelName
//        channelAvatar = channelAvatar
//    }
}


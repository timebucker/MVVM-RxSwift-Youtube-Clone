//
//  VideoViewModel.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/23/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class VideoViewModel {
    let videoList = [VideoModel]()
    let videoListVariable = Variable<[VideoModel]>([])
    var categoryId: String?
    
    init(){
        fetchData()
    }
    
    func fetchData() -> Observable<[VideoModel]>{
        return fetchVideoSnippet(categoryId: categoryId ?? "10").asObservable()
            .flatMapLatest { [weak self] videos -> Observable<[VideoModel]> in
                for video in videos {
                    let channelAvatar = self?.fetchChannelInfo(channelId: video.channelId ?? "")
                    video.channelAvatarURL = channelAvatar
                }
                self?.videoListVariable.value = videos
                return self?.videoListVariable.asObservable() ?? Variable<[VideoModel]>([]).asObservable()
        }
    }
    
    func fetchVideoSnippet(categoryId: String) -> Observable<[VideoModel]> {
        let videosVariable = Variable<[VideoModel]>([])
        
        APIProvider.default.request(.getVideoList(categoryId: categoryId)) { event in
            switch event {
            case let .success(response):
                do {
                    let json: JSON = try JSON(data: response.data, options: [])
                    guard let videosData = json["items"].array else { return }
                    for videoData in videosData {
                        let video = VideoModel()
                        let id = videoData["id"]["videoId"].string
                        video.videoId = id
                        video.videoURL = "https://www.youtube.com/watch?v=\(String(describing: id)))"
                        
                        let videoSnippet = videoData["snippet"]
                        let thumbnail = videoSnippet["thumbnails"]["medium"]["url"].string
                        video.thumbnailURL = thumbnail
                        
                        let title = videoSnippet["title"].string
                        video.title = title
                        
                        let channelId = videoSnippet["channelId"].string
                        video.channelId = channelId
                        
                        let channelName = videoSnippet["channelTitle"].string
                        video.channelName = channelName
            
                        videosVariable.value.append(video)
                    }
                }
                catch {
                    
                }
            case .failure(_): break
            }
        }
        return videosVariable.asObservable()
    }
    
    func fetchChannelInfo(channelId: String) -> String {
        var channelThumbnail = ""
        APIProvider.default.request(.getChannelInfo(channelId: channelId)) { event in
            switch event {
            case let .success(response):
                do {
                        let json: JSON = try JSON(data: response.data, options: [])
                        let channelSnippet = json["items"][0]["snippet"]
                        let thumbnail = channelSnippet["thumbnails"]["default"]["url"].string
                        channelThumbnail = thumbnail ?? ""
                }
                catch {
                    
                }
            case .failure(_): break
            }
        }
        return channelThumbnail
    }
}

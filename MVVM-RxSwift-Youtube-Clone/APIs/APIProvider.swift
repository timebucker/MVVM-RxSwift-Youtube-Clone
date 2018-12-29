//
//  APIProvider.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/21/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import Moya
import MoyaSugar
import SwiftyJSON
import RxSwift
import Alamofire

final class APIProvider: MoyaProvider<VideoAPI> {
    static let `default` = APIProvider()
    
    private init() {
    }
    
    func fetchVideos(videosType: VideoListType, categoryId: String = "") -> Observable<[VideoModel]>{
        switch videosType {
        case .normal:
            return fetchVideoSnippet(categoryId: categoryId)
        case .trending:
            return fetchTrendingVideos()
        default:
            break
        }
    }
    
    func fetchVideoSnippet(categoryId: String) -> Observable<[VideoModel]> {
        return Observable<[VideoModel]>.create({ observer -> Disposable in
            APIProvider.default.request(.getVideoList(categoryId: categoryId)) { event in
                switch event {
                case let .success(response):
                    do {
                        let json: JSON = try JSON(data: response.data, options: [])
                        guard let videosData = json["items"].array else { return }
                        var videos = [VideoModel]()
                        for videoData in videosData {
                            let video = VideoModel()
                            let id = videoData["id"]["videoId"].string
                            video.videoId = id
                            video.videoURL = "https://www.youtube.com/watch?v=\(String(describing: id)))"
                            
                            let videoSnippet = videoData["snippet"]
                            video.thumbnailURL = videoSnippet["thumbnails"]["medium"]["url"].string
                            video.title = videoSnippet["title"].string
                            video.channelId = videoSnippet["channelId"].string
                            video.channelName = videoSnippet["channelTitle"].string
                            
                            videos.append(video)
                        }
                        observer.onNext(videos)
                    }
                    catch {}
                case .failure(_): break
                }
            }
            return Disposables.create()
        })
    }
    
    func fetchTrendingVideos() -> Observable<[VideoModel]> {
        return Observable<[VideoModel]>.create({ observer -> Disposable in
            APIProvider.default.request(.getTrendingVideos) { event in
                switch event {
                case let .success(response):
                    do {
                        let json: JSON = try JSON(data: response.data, options: [])
                        guard let videosData = json["items"].array else { return }
                        var videos = [VideoModel]()
                        for videoData in videosData {
                            let video = VideoModel()
                            let id = videoData["id"]["videoId"].string
                            video.videoId = id
                            video.videoURL = "https://www.youtube.com/watch?v=\(String(describing: id)))"
                            
                            let videoSnippet = videoData["snippet"]
                            video.thumbnailURL = videoSnippet["thumbnails"]["medium"]["url"].string
                            video.title = videoSnippet["title"].string
                            video.channelId = videoSnippet["channelId"].string
                            video.channelName = videoSnippet["channelTitle"].string
                            
                            videos.append(video)
                        }
                        observer.onNext(videos)
                    }
                    catch {}
                case .failure(_): break
                }
            }
            return Disposables.create()
        })
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

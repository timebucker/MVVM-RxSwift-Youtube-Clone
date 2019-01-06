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
    let bag = DisposeBag()

    var categoryId: String?
    var videosType: VideoListType?
    
    lazy var videoListObservable = APIProvider.default.fetchVideos(videosType: videosType ?? VideoListType.normal, categoryId: categoryId ?? "10")
    
    init(){
    }
}

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

final class VideoViewModel {
    let bag = DisposeBag()
    let videosState = BehaviorSubject<StatedData<[VideoModel], String, Void>>(value: .uninitialized)
    
    init(videosType: VideoListType, categotyId: VideoCategoryType){
        APIProvider.default.fetchVideos(videosType: videosType, categoryId: categotyId.rawValue)
            .subscribe(onNext: { [weak self] videoList in
                guard let self = self else { return }
                if videoList.count > 0 {
                    self.videosState.onNext(.data(videoList))
                } else {
                    self.videosState.onNext(.empty)
                }
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    let err = ErrorHandler.handleError(error: error)
                    self.videosState.onNext(.error(err))
                })
                .disposed(by: bag)
    }
}

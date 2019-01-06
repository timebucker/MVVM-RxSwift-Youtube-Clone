//
//  SubscriptionCell.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/16/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import UIKit

class SportCell: FeedCell {
    override func setUpRequestParams() {
        vm.categoryId = VideoCategoryType.sport.rawValue
        vm.videosType = .normal
    }
}

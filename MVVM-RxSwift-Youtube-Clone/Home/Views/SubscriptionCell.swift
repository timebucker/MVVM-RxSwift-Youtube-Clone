//
//  SubscriptionCell.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/16/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func setCategoryId() {
        vm.categoryId = VideoCategoryType.sport.rawValue
    }
}

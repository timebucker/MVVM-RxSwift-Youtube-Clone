////
////  FeedCell.swift
////  MVVM-RxSwift-Youtube-Clone
////
////  Created by Nguyen D.Nhan on 12/16/18.
////  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
////
//
//import UIKit
//import Kingfisher
//import RxSwift
//
//class FeedCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    var vm = VideoViewModel()
//    let bag = DisposeBag()
//    var videoType: VideoListType?
//    var categoryId: VideoCategoryType?
//    var videoList = [VideoModel]()
//
//    var data: (VideoListType, VideoCategoryType)? {
//        didSet {
//            guard let data = data else { return }
//            self.videoType = data.0
//            self.categoryId = data.1
//            vm = VideoViewModel(videosType: videoType ?? .normal, categotyId: categoryId ?? .music)
//            bind()
//        }
//    }
//
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.white
//        cv.dataSource = self
//        cv.delegate = self
//        return cv
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupViews() {
//        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.reuseIdentifier)
//        visualize()
////        bind()
//    }
//
//    func visualize() {
//        backgroundColor = .brown
//
//        collectionView.contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
//        collectionView.scrollIndicatorInsets = .init(top: 50, left: 0, bottom: 0, right: 0)
//
//        addSubview(collectionView)
//        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
//        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
//    }
//
//    func bind() {
//        vm.videosState.asObservable().observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] state in
//                guard let self = self else { return }
//
//                switch state {
//                case .data(let videos):
//                    for video in videos {
//                        print("nhan123: \(video)")
//                    }
//                    self.videoList = videos
//                    self.collectionView.reloadData()
//                case .empty:
//                    print("Request empty")
//                case .noNetwork:
//                    print("No network")
//                case .error(let errorMessage):
//                    print(errorMessage)
//                case .other:
//                    print("Request met other case")
//                default: break
//                }
//            })
//            .disposed(by: bag)
//    }
//
//    func setUpRequestParams(){
//        self.videoType = .trending
//        self.categoryId = .music
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videoList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.reuseIdentifier, for: indexPath) as! VideoCell
//
//        cell.video = videoList[indexPath.row]
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (frame.width - 16 - 16) * 9 / 16
//        return .init(width: frame.width, height: height + 16 + 88)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let videoLauncher = VideoLauncher()
//        videoLauncher.showVideoPlayer(videoID: videoList[indexPath.row].videoId ?? "")
//    }
//}

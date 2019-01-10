//
//  FeedViewController.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 1/10/19.
//  Copyright © 2019 Nguyen D.Nhan. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class FeedViewController: UIViewController {
    let vm: VideoViewModel
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var videoList = [VideoModel]()
    
    let bag = DisposeBag()
    
    init(vm: VideoViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        visualize()
        setupConstraint()
        bind()
    }
    
    func setupView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func visualize() {
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.reuseIdentifier)
        collectionView.backgroundColor = .white
    }
    
    func setupConstraint() {
        
    }
    
    func bind() {
        vm.videosState.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                
                switch state {
                case .data(let videos):
                    for video in videos {
                        print("nhan123: \(video)")
                    }
                    self.videoList = videos
                    self.collectionView.reloadData()
                case .empty:
                    print("Request empty")
                case .noNetwork:
                    print("No network")
                case .error(let errorMessage):
                    print(errorMessage)
                case .other:
                    print("Request met other case")
                default: break
                }
            })
            .disposed(by: bag)
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return .init(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer(videoID: videoList[indexPath.row].videoId ?? "")
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.reuseIdentifier, for: indexPath) as! VideoCell
        cell.video = videoList[indexPath.row]
        return cell
    }
}

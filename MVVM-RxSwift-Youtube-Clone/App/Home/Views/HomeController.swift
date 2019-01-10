//
//  ViewController.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 12/16/18.
//  Copyright © 2018 Nguyen D.Nhan. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class HomeController: UIViewController {
    var titles = [String]()
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let redView = UIView()
    var screenWidth: CGFloat? = nil
    
    let trendingVC = FeedViewController(vm: VideoViewModel(videosType: .trending, categotyId: .music))
    let musicVC = FeedViewController(vm: VideoViewModel(videosType: .normal, categotyId: .music))
    let gamingVC = FeedViewController(vm: VideoViewModel(videosType: .normal, categotyId: .gaming))
    let sportVC = FeedViewController(vm: VideoViewModel(videosType: .normal, categotyId: .sport))
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        visuallize()
        setupConstraint()
        screenWidth = view.frame.width
  
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.brown
        
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.backgroundColor = .white
        addChild(trendingVC)
        scrollView.addSubview(trendingVC.view)
    
        addChild(musicVC)
        scrollView.addSubview(musicVC.view)
        
        addChild(gamingVC)
        scrollView.addSubview(gamingVC.view)
        
        addChild(sportVC)
        scrollView.addSubview(sportVC.view)

        scrollView.delegate = self
    }
    
    func setupView() {
        view.addSubview(scrollView)
        setupMenuBar()
        setupNavBarButtons()
        setupCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height - 50)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(4), height: scrollView.frame.height)
        
        trendingVC.view.frame = CGRect(origin: .zero, size: scrollView.frame.size)
        musicVC.view.frame = trendingVC.view.frame.offsetBy(dx: trendingVC.view.frame.width, dy: 0)
        gamingVC.view.frame = musicVC.view.frame.offsetBy(dx: musicVC.view.frame.width, dy: 0)
        sportVC.view.frame = gamingVC.view.frame.offsetBy(dx: gamingVC.view.frame.width, dy: 0)
    }
    
    func visuallize() {
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = Localization.home.localized()
        self.titles = [Localization.trending.localized(), Localization.music.localized(),
         Localization.gaming.localized(), Localization.sport.localized()]
        titleLabel.text = titles[0]
        scrollToMenuIndex(menuIndex: 0)
        menuBar.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        menuBar.layoutIfNeeded()
        settingsLauncher.refreshForLanguageChange()
    }
    
    func setupConstraint() {
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupMenuBar() {
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
    }
    
    func setupCollectionView() {
      
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    func showControllerForSetting(setting: Setting) {
        if setting.name == Localization.setting.localized() {
            Navigator.shared.showSettingView(VC: DisplaySettingViewController(title: setting.name))
        } else {
            Navigator.shared.showSettingView(VC: SettingViewController(title: setting.name))
        }
    }
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    @objc func handleSearch() {
        scrollToMenuIndex(menuIndex: 2)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        scrollView.setContentOffset(CGPoint(x: screenWidth! * CGFloat(menuIndex), y: 0), animated: false)
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        let indexScreen = scrollView.contentOffset.x/scrollView.frame.width
        
        menuBar.collectionView.selectItem(at: IndexPath(item: Int(indexScreen), section: 0), animated: false, scrollPosition: .centeredHorizontally)
        
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
        
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
    
}

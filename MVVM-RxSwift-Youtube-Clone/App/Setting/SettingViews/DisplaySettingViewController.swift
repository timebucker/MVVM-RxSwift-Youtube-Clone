//
//  GeneralSettingViewController.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 1/9/19.
//  Copyright © 2019 Nguyen D.Nhan. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DisplaySettingViewController: SettingViewController {
    
    let languageLabel = UILabel()
    let themeLabel = UILabel()
    
    var languageOption = BehaviorSubject<Int>(value: 0)
    var themeOption = BehaviorSubject<Int>(value: 0)
    
    let languageButton1 = UIButton()
    let languageButton2 = UIButton()
    
    let themeButton1 = UIButton()
    let themeButton2 = UIButton()
    
    let bag = DisposeBag()
    
    override init(title: String) {
        super.init(title: title)
        
        if Localization.getLocale() == "vi" {
            languageOption.onNext(1)
        }
        
        if Color.appMain.isEqual(Color.customOrange) {
            themeOption.onNext(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        visualize()
        bind()
    }
    
    func setupView() {
        view.addSubview(languageLabel)
        view.addSubview(themeLabel)
        view.addSubview(themeButton1)
        view.addSubview(themeButton2)
        view.addSubview(languageButton1)
        view.addSubview(languageButton2)
    }
    
    func visualize() {
        self.navigationController?.navigationBar.topItem?.title = ""
        
        languageLabel.sizeToFit()
        languageLabel.text = Localization.appLanguage.localized()
        
        themeButton1.backgroundColor = Color.customRed
        
        themeButton2.backgroundColor = Color.customOrange
        
        languageButton1.setTitle("English", for: .normal)
        languageButton1.setTitleColor(.black, for: .normal)
        
        languageButton2.setTitle("Tiếng Việt", for: .normal)
        languageButton2.setTitleColor(.black, for: .normal)
        
        themeLabel.sizeToFit()
        themeLabel.text = Localization.appTheme.localized()
    }
    
    func setupConstraint() {
        themeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        themeButton1.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview().offset(-60)
            make.top.equalTo(themeLabel.snp.bottom).offset(20)
        }
        
        themeButton2.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview().offset(60)
            make.top.equalTo(themeLabel.snp.bottom).offset(20)
        }
        
        languageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(themeButton1.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        languageButton1.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.centerX.equalToSuperview().offset(-60)
            make.top.equalTo(languageLabel.snp.bottom).offset(20)
        }
        
        languageButton2.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.centerX.equalToSuperview().offset(60)
            make.top.equalTo(languageLabel.snp.bottom).offset(20)
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.navigationItem.title = Localization.setting.localized()
    }
    
    func bind() {
        
        themeButton1.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.themeOption.onNext(0)
        })
        .disposed(by: bag)
        
        themeButton2.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.themeOption.onNext(1)
        })
        .disposed(by: bag)
        
        languageButton1.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.languageOption.onNext(0)
        })
        .disposed(by: bag)
        
        languageButton2.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.languageOption.onNext(1)
        })
        .disposed(by: bag)
        
        themeOption.asObserver()
            .subscribe(onNext: { [weak self] option in
                guard let self = self else { return }
                switch option {
                case 0:
                    self.addButtonBorder(button: self.themeButton1)
                    self.removeButtonBorder(button: self.themeButton2)
                    Navigator.shared.navigationVC.navigationBar.barTintColor = Color.customRed
                    Color.appMain = Color.customRed
                case 1:
                    self.addButtonBorder(button: self.themeButton2)
                    self.removeButtonBorder(button: self.themeButton1)
                    Navigator.shared.navigationVC.navigationBar.barTintColor = Color.customOrange
                    Color.appMain = Color.customOrange
                default:
                    break;
                }
            })
            .disposed(by: bag)
        
        languageOption.asObserver()
            .subscribe(onNext: { [weak self] option in
                guard let self = self else { return }
                switch option {
                case 0:
                    self.languageButton1.setTitleColor(.red, for: .normal)
                    self.languageButton2.setTitleColor(.black, for: .normal)
                    LocalizeService.shared.setLocale(locale: "en")
                    self.view.layoutIfNeeded()
                case 1:
                    self.languageButton1.setTitleColor(.black, for: .normal)
                    self.languageButton2.setTitleColor(.red, for: .normal)
                    LocalizeService.shared.setLocale(locale: "vi")
                    self.view.layoutIfNeeded()
                default:
                    break;
                }
            })
            .disposed(by: bag)
    }
    
    func addButtonBorder(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    func removeButtonBorder(button: UIButton) {
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 0
    }
}

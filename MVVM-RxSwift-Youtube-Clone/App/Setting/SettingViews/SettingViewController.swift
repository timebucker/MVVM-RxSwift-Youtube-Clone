//
//  SettingViewController.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 1/9/19.
//  Copyright © 2019 Nguyen D.Nhan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    var VCtitle: String?
    
    init(title: String){
        super.init(nibName: nil, bundle: nil)
        self.VCtitle = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = self.VCtitle ?? ""
    }
}

//
//  LocalizeService.swift
//  MVVM-RxSwift-Youtube-Clone
//
//  Created by Nguyen D.Nhan on 1/7/19.
//  Copyright © 2019 Nguyen D.Nhan. All rights reserved.
//

import Foundation

extension Localization {
    static func getLocale() -> String {
        return LocalizeService.shared.locale
    }
    
    @inline(__always) func localized() -> String {
        return Bundle.main.localizedString(forKey: String(describing: self),
                                           value: "",
                                           table: Localization.getLocale())
    }
}


private final class LocalizeService {
    static let shared = LocalizeService()
    
    let supportedLocales = ["en", "vi"]
    
    private(set) var locale: String
    
    private init() {
        for locale in Bundle.main.preferredLocalizations {
            if supportedLocales.contains(locale) {
                self.locale = locale
                return
            }
        }
        
        locale = supportedLocales.first!
    }
}

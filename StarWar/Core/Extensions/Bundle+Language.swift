//
//  Bundle+Language.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 20.07.24.
//

import Foundation

private var bundleKey: UInt8 = 0

final class AnyLanguageBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    static let once: Void = {
        object_setClass(Bundle.main, AnyLanguageBundle.self)
    }()
    
    static func setLanguage(_ language: String) {
        Bundle.once
        let isLanguageRTL = NSLocale.characterDirection(forLanguage: language) == .rightToLeft
        UserDefaults.standard.set(isLanguageRTL, forKey: "AppleTextDirection")
        UserDefaults.standard.set(isLanguageRTL, forKey: "NSForceRightToLeftWritingDirection")
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = path != nil ? Bundle(path: path!) : nil
        objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

//
//  LanguageManager.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 20.07.24.
//

import Foundation
import Combine

enum Language: String {
    case en
    case es
}

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: Language {
        didSet {
            AppStorageManager.shared.language = currentLanguage
            Bundle.setLanguage(currentLanguage.rawValue)
            NotificationCenter.default.post(name: .languageDidChange, object: nil)
        }
    }
    
    init() {
        currentLanguage = AppStorageManager.shared.language
    }
}

extension Notification.Name {
    static let languageDidChange = Notification.Name("languageDidChange")
}

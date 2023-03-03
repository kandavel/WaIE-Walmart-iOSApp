//
//  UserDefaultsManager.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation
final class UserDataProvider {

    private let userDefaults: UserDefaults
    
    struct keyConstant {
        static let lastSeenImageURLKey  =  "lastSeenImageURL"
        static let userVisitCounttKey  =  "userVisitedCount"
        static let apodTitleKey  = "apodTitle"
        static let apodexplanantionKey = "apodExplanation"
    }

    init() {
        userDefaults = UserDefaults.standard
    }

    func getUserVisitedCount() -> Int {
      return  (userDefaults.object(forKey: keyConstant.userVisitCounttKey) as? Int) ?? 0
    }
    
    func setUserVisitedCount() {
        let count = getUserVisitedCount() + 1
        userDefaults.set(count, forKey: keyConstant.userVisitCounttKey)
    }
    
    func getLastSeenImageUrl() -> Data? {
        return userDefaults.object(forKey: keyConstant.lastSeenImageURLKey) as? Data
    }

    func setLastSeenImageUrl(data : Data?) {
        userDefaults.setValue(data, forKey: keyConstant.lastSeenImageURLKey)
    }
    
    func getapodTitle() -> String? {
        (userDefaults.object(forKey: keyConstant.apodTitleKey) as? String) ?? ""
    }
    
    func setapodTitle(title : String?) {
        userDefaults.set(title, forKey: keyConstant.apodTitleKey)
    }
    
    func getapodExplanantion() -> String? {
        (userDefaults.object(forKey: keyConstant.apodexplanantionKey) as? String) ?? ""
    }
    
    func setapodExplanantion(explanantion : String?) {
        userDefaults.set(explanantion, forKey: keyConstant.apodexplanantionKey)
    }
    
    fileprivate func sync() {
        userDefaults.synchronize()
    }
    
}

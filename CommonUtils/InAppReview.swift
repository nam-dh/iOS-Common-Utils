//
//  InAppReview.swift
//  CommonUtils
//
//  Created by Nam Doan on 2017/11/24.
//  Copyright © 2017年 NamDH. All rights reserved.
//

import StoreKit

public struct InAppReview {
    // Need to be called when app starts
    public static func setup() {
        if isAppUpdated {
            reset()
        } else {
            increaseCount()
        }
    }

    @discardableResult
    public static func showRequestAppReview(in viewController: UIViewController) -> Bool {
        if needShow, #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            isOff = true
            return true
        } else {
            return false
        }
    }

    static var needShow: Bool {
        if isOff { return false }
        else {
            return count >= 10
        }
    }
    static func increaseCount() { count += 1 }
    static func reset() {
        count = 0
        isOff = false
    }
    static var isOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "app_rate_off")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "app_rate_off")
            UserDefaults.standard.synchronize()
        }
    }
    private static var count: Int {
        get {
            return UserDefaults.standard.integer(forKey: "app_rate_count")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "app_rate_count")
            UserDefaults.standard.synchronize()
        }
    }

    private static var isAppUpdated: Bool {
        let defaults = UserDefaults.standard
        let currentVersion = AppInfo.version

        guard let previousVersion = defaults.string(forKey: "app_version") else {
            print("fresh install")
            defaults.set(currentVersion, forKey: "app_version")
            return false
        }

        // Updating new version to UserDefaults
        defaults.set(currentVersion, forKey: "app_version")
        defaults.synchronize()
        let comparisonResult = currentVersion.compare(previousVersion, options: .numeric, range: nil, locale: nil)
        switch comparisonResult {
        case .orderedSame:
            print("same version is running like before")
            return false
        case .orderedAscending:
            print("earlier version is running like before")
            return false
        case .orderedDescending:
            print("older version is running like before")
            return true
        }
    }
}

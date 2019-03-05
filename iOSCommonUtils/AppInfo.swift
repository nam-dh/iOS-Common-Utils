//
//  AppInfo.swift
//  CommonUtils
//
//  Created by Nam Doan on 2017/11/24.
//  Copyright © 2017年 NamDH. All rights reserved.
//

import Foundation

public struct AppInfo {
    public static var name: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }

    public static var version: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
}

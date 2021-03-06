//
//  Utilities.swift
//  CommonUtils
//
//  Created by Nam Doan on 2017/11/24.
//  Copyright © 2017年 NamDH. All rights reserved.
//

import Foundation
import AVFoundation

public struct CommonUtils {
    @discardableResult
    public static func inline<T>(_ obj: T?, execute work: (T) -> Void) -> T? {
        guard let obj = obj else {
            return nil
        }
        work(obj)
        return obj
    }

    public static func localizedString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    public static func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }

    public static func getFaviconURL(domain: String) -> URL? {
        if domain.isBlankURL {
            return nil
        } else {
            let faviconPrefix = "https://www.google.com/s2/favicons?domain="
            return "\(faviconPrefix)\(domain)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)?.url
        }
    }

    public static func addSubview(subView: UIView, toView parentView: UIView) {
        let topConstraint = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: parentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: subView, attribute: .trailing, relatedBy: .equal, toItem: parentView, attribute: .trailing, multiplier: 1, constant: 0)
        subView.frame = parentView.bounds
        parentView.addSubview(subView)
        parentView.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        parentView.layoutIfNeeded()
    }
}

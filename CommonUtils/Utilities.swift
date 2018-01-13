//
//  Utilities.swift
//  CommonUtils
//
//  Created by Nam Doan on 2017/11/24.
//  Copyright © 2017年 NamDH. All rights reserved.
//

import Foundation

public struct CommonUtils {
    @discardableResult
    public static func inline<T>(_ obj: T?, execute work: (T) -> Void) -> T? {
        guard let obj = obj else {
            return nil
        }
        work(obj)
        return obj
    }

    public static var documentsDirectory: String {
        return documentsDirectoryURL.absoluteString
    }

    public static var documentsDirectoryURL: URL {
        return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
    }

    public static func isExistedInDocumentDirectory(_ fileName: String) -> Bool {
        let filePath = pathFileInDocumentDirectory(fileName)
        return FileManager.default.fileExists(atPath: filePath)
    }

    public static func pathFileInDocumentDirectory(_ fileName: String) -> String {
        return urlFileInDocumentDirectory(fileName).path
    }

    public static func urlFileInDocumentDirectory(_ fileName: String) -> URL {
        return self.documentsDirectoryURL.appendingPathComponent(fileName)
    }

    public static func removeFileInDocumentDirectory(fileName: String) {
        guard isExistedInDocumentDirectory(fileName) else { return }
        let filePath = pathFileInDocumentDirectory(fileName)
        self.removeFile(at: filePath)
    }

    public static func removeFile(at path: String) {
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print(error)
        }
    }

    public static func storeImageToDocumentDirectory(image: UIImage, fileName: String) -> URL? {
        guard let data = UIImagePNGRepresentation(image) else {
            return nil
        }
        let fileName = self.urlFileInDocumentDirectory(fileName)
        do {
            try data.write(to: fileName)
            return fileName
        } catch {
            return nil
        }
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
            let faviconPrefix = "http://www.google.com/s2/favicons?domain="
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

// MARK: - Dispatch

/// Utility class for safely dispatching to a queue.
/// Currently only supports the main queue.
final class DispatchQueueSafe {
    private static var instance = DispatchQueueSafe()
    static var main: DispatchQueueSafe {
        return DispatchQueueSafe.instance
    }
    func sync(_ block: () -> ()) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.sync(execute: block)
        }
    }
}

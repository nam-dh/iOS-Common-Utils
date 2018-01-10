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
}

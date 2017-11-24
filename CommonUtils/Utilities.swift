//
//  Utilities.swift
//  CommonUtils
//
//  Created by Nam Doan on 2017/11/24.
//  Copyright © 2017年 NamDH. All rights reserved.
//

import Foundation

public struct Utils {
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
        return self.documentsDirectoryURL.appendingPathComponent(fileName).path
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

    public static func localizedString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

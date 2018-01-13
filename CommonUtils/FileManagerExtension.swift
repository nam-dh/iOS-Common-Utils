//
//  FileManagerExtension.swift
//  CommonUtils
//
//  Created by Nam Doan on 2018/04/01.
//  Copyright © 2018 NamDH. All rights reserved.
//

import Foundation

public extension FileManager {

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
    
    public static func createFolder(at path: String) {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            do {
                try fileManager.createDirectory(atPath: path,
                                                withIntermediateDirectories: false,
                                                attributes: nil)
            } catch {
                print("Error creating images folder in documents dir: \(error)")
            }
        }
    }

    public enum RenameError: Error {
        case unknown
    }

    public static func renameItemAtURL(_ path: String, newName: String) throws {
        let directoryPath = (path as NSString).deletingLastPathComponent
        let newPath = "\(directoryPath)/\(newName)"
        do {
            try FileManager.default.moveItem(atPath: path, toPath: newPath)
        } catch {
            print(error)
            throw RenameError.unknown
        }
    }

    public static func intSizeForLocalFile(filePath: String) -> UInt64 {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: filePath)
            if let fileSize = fileAttributes[FileAttributeKey.size]  {
                return (fileSize as? NSNumber)?.uint64Value ?? 0
            } else {
                print("Failed to get a size attribute from path: \(filePath)")
            }
        } catch {
            print("Failed to get file attributes for local path: \(filePath) with error: \(error)")
        }
        return 0
    }

    public static func stringSizeForLocalFile(filePath: String) -> String {
        let size = self.intSizeForLocalFile(filePath: filePath)
        return self.convertToFileString(with: size)
    }

    public static func convertToFileString(with size: UInt64) -> String {
        var convertedValue: Double = Double(size)
        var multiplyFactor = 0
        let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
        while convertedValue > 1024 {
            convertedValue /= 1024
            multiplyFactor += 1
        }
        return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
    }
}

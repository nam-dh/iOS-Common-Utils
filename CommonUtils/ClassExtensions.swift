//
//  ClassExtensions.swift
//  CommonUtils
//
//  Created by Nam Doan on 2017/11/24.
//  Copyright © 2017年 NamDH. All rights reserved.
//

import UIKit

public extension NSObject {
    @nonobjc
    public static var className: String { return String(describing: self) }

    public var className: String { return type(of: self).className }
}

public extension Array {
    var blankToNil: [Element]? { return isEmpty ? nil : self }

    func element(at index: Int) -> Element? {
        guard index >= 0 && count > index else {
            return nil
        }
        return self[index]
    }
}

public extension UIColor {
    public convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let r = (hex >> 16) & 0xff
        let g = (hex >> 8) & 0xff
        let b = (hex) & 0xff

        self.init(red: CGFloat(r) / CGFloat(255.0), green: CGFloat(g) / CGFloat(255.0), blue: CGFloat(b) / CGFloat(255.0), alpha: alpha)
    }
}

public extension UIBarButtonItem {
    public func hide() {
        self.isEnabled = false
        self.tintColor = .clear
    }

    public func show() {
        self.isEnabled = true
        self.tintColor = nil
    }

    public static var noTitleButton: UIBarButtonItem {
        let item = UIBarButtonItem()
        item.title = ""
        return item
    }
}

public extension String {
    public var url: URL? {
        return URL(string: self)
    }

    public static let blankPageURL: String = "about:blank"

    public var isBlankURL: Bool {
        return self.isEmpty || self == String.blankPageURL
    }
}

public extension URL {
    public static let blankPage = URL(string: String.blankPageURL)
}

public extension CGRect {
    public var bounds: CGRect { return CGRect(origin: CGPoint.zero, size: size) }
    public var center: CGPoint { return CGPoint(x: minX + bounds.midX, y: minY + bounds.midY) }
}

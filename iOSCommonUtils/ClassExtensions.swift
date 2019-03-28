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
    static var className: String { return String(describing: self) }

    var className: String { return type(of: self).className }
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
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let r = (hex >> 16) & 0xff
        let g = (hex >> 8) & 0xff
        let b = (hex) & 0xff

        self.init(red: CGFloat(r) / CGFloat(255.0), green: CGFloat(g) / CGFloat(255.0), blue: CGFloat(b) / CGFloat(255.0), alpha: alpha)
    }
}

public extension UIBarButtonItem {
    func hide() {
        self.isEnabled = false
        self.tintColor = .clear
    }

    func show() {
        self.isEnabled = true
        self.tintColor = nil
    }

    static var noTitleButton: UIBarButtonItem {
        let item = UIBarButtonItem()
        item.title = ""
        return item
    }
}

public extension String {
    var url: URL? {
        return URL(string: self)
    }

    static let blankPageURL: String = "about:blank"

    var isBlankURL: Bool {
        return self.isEmpty || self == String.blankPageURL
    }
}

public extension URL {
    static let blankPage = URL(string: String.blankPageURL)
}

public extension CGRect {
    var bounds: CGRect { return CGRect(origin: CGPoint.zero, size: size) }
    var center: CGPoint { return CGPoint(x: minX + bounds.midX, y: minY + bounds.midY) }

    init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.init()
        self.origin = CGPoint(x: x, y: y)
        self.size = CGSize(width: width, height: height)
    }

    init(_ x: Int, _ y: Int, _ width: Int, _ height: Int) {
        self.init()
        self.origin = CGPoint(x: CGFloat(x), y: CGFloat(y))
        self.size = CGSize(width: CGFloat(width), height: CGFloat(height))
    }

    init(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
        self.init()
        self.origin = CGPoint(x: CGFloat(x), y: CGFloat(y))
        self.size = CGSize(width: CGFloat(width), height: CGFloat(height))
    }

    func set(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) -> CGRect {
        return CGRect(x ?? minX, y ?? minY, width ?? self.width, height ?? self.height)
    }
}

public extension UIViewController {
    func removeBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

public extension UIBarButtonItem {
    var frame: CGRect? {
        guard let view = self.value(forKey: "view") as? UIView else {
            return nil
        }
        return view.frame
    }
}

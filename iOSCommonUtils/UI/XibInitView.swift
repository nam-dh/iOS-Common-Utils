//
//  XibInitView.swift
//  CommonUtils
//
//  Created by Nam Doan on 2018/03/11.
//  Copyright © 2018 NamDH. All rights reserved.
//

import UIKit

public protocol XibInitViewProtocol {
    var contentView: UIView! { get }
}

open class XibInitView: UIView, XibInitViewProtocol {
    open class var staticHeight: CGFloat { return 0 }

    @IBOutlet open var contentView: UIView!
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(self.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

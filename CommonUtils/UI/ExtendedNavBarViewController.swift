//
//  ExtendedNavBarViewController.swift
//  CommonUtils
//
//  Created by Nam Doan on 2018/01/13.
//  Copyright © 2018 NamDH. All rights reserved.
//

import UIKit

open class ExtendedNavBarViewController: UIViewController {
    @IBOutlet weak var navBarView: UIView!
    var navBarColor = UIColor.white {
        didSet {
            navBarView.backgroundColor = self.navBarColor
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        removeNavBarShadow()
        navBarView.backgroundColor = self.navBarColor
    }

    private func removeNavBarShadow() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}

public extension UIViewController {
    var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.size.height ?? 0
    }
}

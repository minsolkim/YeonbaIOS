//
//  UIView+.swift
//  YeonBa
//
//  Created by 김민솔 on 5/4/24.
//

import Foundation
import UIKit.UIView

extension UIView {
    public func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0)}
    }
    
}

extension UIView {
    public var safeAreaHeight: CGFloat {
        let verticalSafeAreaInset = self.safeAreaInsets.bottom + self.safeAreaInsets.top
        let safeAreaHeight = self.frame.height - verticalSafeAreaInset
        return safeAreaHeight
    }
}

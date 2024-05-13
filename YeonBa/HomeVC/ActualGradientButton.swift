//
//  ActualGradientButton.swift
//  YeonBa
//
//  Created by 김민솔 on 3/6/24.
//

import Foundation
import UIKit

class ActualGradientButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.colors = [UIColor.secondary?.cgColor, UIColor.primary?.cgColor]
        l.startPoint = CGPoint(x: 0.5, y: 0)
        l.endPoint = CGPoint(x: 0.5, y: 1)
        l.cornerRadius = 20
        layer.insertSublayer(l, at: 0)
        return l
    }()
}

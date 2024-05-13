//
//  DeclarLabel.swift
//  YeonBa
//
//  Created by 김민솔 on 3/28/24.
//

import Foundation

import UIKit

final class DeclarLabel: UILabel {
    init(font: UIFont.TextStyle, isBold: Bool = false, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .pretendardMedium(size: 20)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

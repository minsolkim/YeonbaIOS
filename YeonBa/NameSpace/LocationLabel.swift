//
//  LocationLabel.swift
//  YeonBa
//
//  Created by 김민솔 on 3/30/24.
//

import Foundation
import UIKit

final class LocationLabel: UILabel {
    init(font: UIFont.TextStyle, isBold: Bool = false, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .pretendardMedium(size: 16)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

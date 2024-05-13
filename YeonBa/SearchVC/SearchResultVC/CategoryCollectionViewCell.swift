//
//  CategoryCollectionViewCell.swift
//  YeonBa
//
//  Created by 김민솔 on 4/1/24.
//

import UIKit
import Then
import SnapKit


class CategoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "categoryCell"
    private let categoryLabel = UILabel().then {
        $0.text = "전체지역"
        $0.textAlignment = .center
        $0.font = .pretendardMedium(size: 13)
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

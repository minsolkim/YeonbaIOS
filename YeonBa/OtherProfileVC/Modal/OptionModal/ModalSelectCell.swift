//
//  ModalSelectCell.swift
//  YeonBa
//
//  Created by 김민솔 on 3/28/24.
//

import UIKit
import SnapKit
import Then


final class ModeSelectCell: UITableViewCell {
    private let optionImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
    }()
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.init(named: "declareBtn")
        return imageView
    }()
    private let optionLabel: UILabel = DeclarLabel(font: .body)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(label: NSAttributedString, image: UIImage?, isChecked: Bool) {
        optionLabel.attributedText = label // NSAttributedString으로 설정
        optionImageView.image = image // 이미지 설정

        //checkImageView.isHidden = !isChecked
    }
}

// MARK: Setup Layout
private extension ModeSelectCell {
    
    func addSubviews() {
        addSubview(optionImageView)
        addSubview(optionLabel)
        addSubview(checkImageView)
    }
    
    func setupLayout() {
        optionImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
        optionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(optionImageView.snp.trailing).offset(16)
        }
        checkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(25)
        }
    }
}

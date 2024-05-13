//
//  FavoriteVoiceTableViewCell.swift
//  YeonBa
//
//  Created by jin on 4/10/24.
//

import UIKit
import SnapKit
import Then

final class FavoriteVoiceTableViewCell: UITableViewCell {
    private let optionLabel: UILabel = BoundGrayLabel(font: .body)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.borderColor = UIColor.customgray2?.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        addSubviews()
        setupLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    override var isSelected: Bool {
      didSet {
        if isSelected {
            contentView.layer.borderColor = UIColor.primary?.cgColor
            optionLabel.textColor = UIColor.primary

        }else {
            contentView.layer.borderColor = UIColor.customgray2?.cgColor // 선택이 해제될 때 기본 색상으로 변경
            optionLabel.textColor = UIColor.black // 선택이 해제될 때 기본 색상으로 변경


        }
      }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.layer.borderColor = UIColor.primary?.cgColor
            optionLabel.textColor = UIColor.primary
        } else {
            contentView.layer.borderColor = UIColor.customgray2?.cgColor
            optionLabel.textColor = UIColor.black // 선택이 해제될 때 기본 색상으로 변경
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setup(label: String) {
        optionLabel.text = label
    }
}

// MARK: Setup Layout
private extension FavoriteVoiceTableViewCell {
    
    func addSubviews() {
        addSubview(optionLabel)
    }
    
    func setupLayout() {
        optionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-7)
            $0.leading.equalToSuperview().inset(20)
        }
        
    }
}

//
//  PhotoCollectionViewCell.swift
//  YeonBa
//
//  Created by 김민솔 on 4/17/24.
//

import UIKit
import Photos
import SnapKit
import Then


class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - UI Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func configure(with asset: PHAsset) {
        PHImageManager.default().requestImage(
            for: asset,
            targetSize: CGSize(width: frame.size.width, height: frame.size.height),
            contentMode: .aspectFill,
            options: nil) { [weak imageView] image, _ in
                imageView?.image = image
            }
    }
    // 재사용 준비
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

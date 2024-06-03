//
//  PhotoPlaceHolderView.swift
//  YeonBa
//
//  Created by 김민솔 on 4/10/24.
//

import Foundation
import UIKit
import Photos
import PhotosUI

protocol PhotoPlaceholderViewDelegate: AnyObject {
    func updatePieChart(with value: Double)
    func didUpdatePhotoCount(_ count: Int, total: Int)
    func updateAddButton()
}
class PhotoPlaceholderView: DottedBorderView, PhotoSelectionDelegate {
    weak var delegate: PhotoPlaceholderViewDelegate?

    func didSelectPhoto(_ image: UIImage) {
        imageView.image = image
        let resizedImage = image.resizeImage(image: image, newWidth: 200) // 폭이 200인 이미지로 리사이징
            
            // 리사이징된 이미지를 배열에 추가
        SignDataManager.shared.selectedImages.append(resizedImage)
        print("selectedImages contents: \(SignDataManager.shared.selectedImages)")
        imageView.isHidden = false
        hintLabel.isHidden = true
        delegate?.updateAddButton()
        delegate?.updatePieChart(with: 50)
        delegate?.didUpdatePhotoCount(1, total: 2)

    }
    
    // MARK: - Properties
    
    private let hintLabel = UILabel().then {
        $0.textColor = .customgray3
        $0.textAlignment = .center
        $0.font = .pretendardSemiBold(size: 20)
    }
    
    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
        $0.clipsToBounds = true
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layer.borderColor = UIColor(hex: "616161").cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = UIColor(hex: "EFEFEF")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        addSubview(hintLabel)
        addSubview(imageView)
        setupConstraints()
        layer.addDottedBorder()
    }
    
    private func setupConstraints() {
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public Methods
    
    func setHintText(_ text: String) {
        hintLabel.text = text
    }
    
    // MARK: - Actions
    
    @objc private func didTapView() {
        let galleryVC = CustomPhotoGalleryViewController()
        galleryVC.delegate = self
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            let navController = rootViewController as? UINavigationController ?? rootViewController.navigationController
            navController?.pushViewController(galleryVC, animated: true)
            
        }
    }
}




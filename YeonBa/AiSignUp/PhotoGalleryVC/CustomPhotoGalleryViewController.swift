//
//  CustomPhotoGalleryViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 4/17/24.
//

import UIKit
import Photos

protocol PhotoSelectionDelegate: AnyObject {
    func didSelectPhoto(_ image: UIImage)
}
class CustomPhotoGalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    weak var delegate: PhotoSelectionDelegate? // 델리게이트 속성 추가
    var allPhotos: PHFetchResult<PHAsset>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // 최신순으로 정렬하기 위해 ascending 값을 false로 설정
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "사진 앨범"
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width/3)-1, height: (view.frame.width/3)-1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        let asset = allPhotos.object(at: indexPath.item)
        cell.configure(with: asset)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = allPhotos.object(at: indexPath.item)
        let options = PHImageRequestOptions()
        options.isSynchronous = true // 동기적 요청으로 설정합니다.
        options.deliveryMode = .highQualityFormat // 최고 품질의 이미지를 요청합니다.
        
        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { [weak self] image, info in
            guard let strongSelf = self, let image = image else { return }
            if let isDegradedImage = info?[PHImageResultIsDegradedKey] as? Bool, !isDegradedImage {
                let photoDetailVC = FullScreenImageViewController(image: image)
                photoDetailVC.delegate = self?.delegate
                self?.navigationController?.pushViewController(photoDetailVC, animated: true)
            }
        }
    }
    
}


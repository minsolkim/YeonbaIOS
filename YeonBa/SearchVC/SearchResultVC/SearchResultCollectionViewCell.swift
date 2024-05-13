//
//  SearchResultCollectionViewCell.swift
//  YeonBa
//
//  Created by 김민솔 on 4/1/24.
//

import UIKit
import Then
import SnapKit
import Charts

class SearchResultCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "searchResultCell"
    //MARK: -- UI Component
    private let cupidImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    private let favoriteBtn = UIButton().then {
        $0.setImage(UIImage(named: "WhiteFavorites"), for: .normal)
    }
    
    private let pieChartView = PieChartView() //유사도
    private let similarityLabel = UILabel().then {
        $0.text = "80%"
        $0.textColor = UIColor.primary
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 19.1)
    }
    private let nameLabel = UILabel().then {
        $0.text = "쥬하"
        $0.textAlignment = .center
        $0.font = .pretendardSemiBold(size: 26)
        $0.textColor = .white
    }
    private let ageLabel = UILabel().then {
        $0.text = "22"
        $0.textAlignment = .center
        $0.font = .pretendardSemiBold(size: 20)
        $0.textColor = .white
    }
    private let heartImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "Homeheart")
    }
    private let heartLabel = UILabel().then {
        $0.text = "231"
        $0.textColor = UIColor.primary
        $0.textAlignment = .center
        $0.font = UIFont.pretendardRegular(size: 13)
    }
    private let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    private let watchProfileBtn = UIButton().then {
        $0.setTitle("프로필 보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.masksToBounds = true
        $0.layer.backgroundColor = UIColor.white.cgColor
        $0.layer.cornerRadius = 25
    }
    private let sendChatBtn = ActualGradientButton().then {
        $0.setTitle("채팅 보내기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 25
        $0.layer.masksToBounds = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadImage()
        addSubview()
        configUI()
        setupPieChart()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubview() {
        contentView.addSubview(cupidImageView)
        contentView.addSubview(favoriteBtn)
        contentView.addSubview(similarityLabel)
        contentView.addSubview(pieChartView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(heartImage)
        contentView.addSubview(heartLabel)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(watchProfileBtn)
        horizontalStackView.addArrangedSubview(sendChatBtn)
        
    }
    private func configUI() {
        cupidImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        favoriteBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        similarityLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(36)
            $0.top.equalToSuperview().inset(53)
        }
        pieChartView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(113)
            $0.width.equalTo(113)
        }
        horizontalStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalTo(pieChartView.snp.bottom).offset(120)
            
        }
        ageLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(10)
            $0.bottom.equalTo(nameLabel.snp.bottom)
        }
        heartImage.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        heartLabel.snp.makeConstraints {
            $0.leading.equalTo(heartImage.snp.trailing).offset(10)
            $0.top.equalTo(heartImage.snp.top)
        }
    }
    private func loadImage() {
        guard let url = URL(string:"https://static.news.zumst.com/images/58/2023/10/23/0cb287d9a1e2447ea120fc5f3b0fcc11.jpg") else { return }
        cupidImageView.kf.setImage(with: url)
    }
    private func setupPieChart() {
        let entries = [PieChartDataEntry(value: 90), PieChartDataEntry(value: 10)]

        let dataSet = PieChartDataSet(entries: entries)
        if let customPinkColor = UIColor.primary {
            let otherColor = UIColor.white
            dataSet.colors = [customPinkColor, otherColor]
        }
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false
        let data = PieChartData(dataSet: dataSet)
        
        pieChartView.holeRadiusPercent = 0.9
        pieChartView.holeColor = UIColor.clear // 배경색을 투명하게 설정
        
        pieChartView.data = data
        pieChartView.legend.enabled = false
    }
    
}

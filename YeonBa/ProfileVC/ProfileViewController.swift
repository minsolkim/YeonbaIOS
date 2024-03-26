//
//  ProfileViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 3/26/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher
import Charts

class ProfileViewController: UIViewController {
    private let scrollview = UIScrollView()
    
    private let cupidImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let pieChartView = PieChartView() //유사도
    private let similarityLabel = UILabel().then {
        $0.text = "80%"
        $0.textColor = UIColor.primary
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 19.1)
    }
    private let declareBtn = UIButton().then {
        $0.setImage(UIImage(named: "Declaration"), for: .normal)
    }
    private let favoriteBtn = UIButton().then {
        $0.setImage(UIImage(named: "PinkFavorites"), for: .normal)
    }
    
    private let heartImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "profileheart")
    }
    private let heartLabel = UILabel().then {
        $0.text = "231"
        $0.textColor = UIColor.primary
        $0.textAlignment = .center
        $0.font = UIFont.pretendardRegular(size: 13)
    }
    private let nameLabel = UILabel().then {
        $0.text = "쥬하"
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 24)

    }
    private let totalLabel = UILabel().then {
        $0.text = "Total"
        $0.font = UIFont.pretendardSemiBold(size: 16)
        $0.textAlignment = .center
    }
    
    private let barView = UIView().then {
        $0.backgroundColor = .gray3
        
    }
    private let aboutLabel = UILabel().then {
        $0.text = "About Me"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 20)
    }
    private let ageLabel = UILabel().then {
        $0.text = "22살"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    private let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    private let sendBtn = UIButton().then {
        $0.setTitle("화살 보내기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 20
    }
    private let sendChatBtn = ActualGradientButton().then {
        $0.setTitle("채팅 보내기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    // MARK: - 탭바제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController as? tabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        if let tabBarController = self.tabBarController as? tabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPieChart()
        addSubviews()
        configUI()
        loadImage()
       
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
        view.backgroundColor = .white
    }
    func addSubviews() {
        view.addSubview(cupidImageView)
        cupidImageView.addSubview(declareBtn)
        cupidImageView.addSubview(similarityLabel)
        cupidImageView.addSubview(pieChartView)
        cupidImageView.addSubview(favoriteBtn)
        view.addSubview(horizontalStackView)
        view.addSubview(nameLabel)
        view.addSubview(totalLabel)
        view.addSubview(heartImage)
        view.addSubview(heartLabel)
        view.addSubview(barView)
        view.addSubview(aboutLabel)
        horizontalStackView.addArrangedSubview(sendBtn)
        horizontalStackView.addArrangedSubview(sendChatBtn)
        
    }
    func configUI() {
        cupidImageView.snp.makeConstraints { make in
            //make.top.equalToSuperview().inset(45)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        declareBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(40)
        }
        similarityLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.bottom.equalToSuperview().inset(45)
            $0.height.equalTo(50)
        }
        pieChartView.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
            $0.height.equalTo(120)
            $0.width.equalTo(120)
        }
        favoriteBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(cupidImageView.snp.bottom).offset(20)
            $0.bottom.equalTo(totalLabel.snp.bottom)
        }
        totalLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(220)
            $0.top.equalTo(cupidImageView.snp.bottom).offset(30)
        }
        heartImage.snp.makeConstraints {
            $0.leading.equalTo(totalLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(totalLabel.snp.bottom)
        }
        barView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        aboutLabel.snp.makeConstraints {
            $0.top.equalTo(barView.snp.bottom).offset(20)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        heartLabel.snp.makeConstraints {
            $0.leading.equalTo(heartImage.snp.trailing).offset(5)
            $0.bottom.equalTo(heartImage.snp.bottom)
        }
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        
        
    }
    func setupPieChart() {
        let entries = [PieChartDataEntry(value: 90), PieChartDataEntry(value: 10)]

        let dataSet = PieChartDataSet(entries: entries)
        if let customPinkColor = UIColor.primary {
            let otherColor = UIColor.white
            dataSet.colors = [customPinkColor, otherColor]
        }
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false
        let data = PieChartData(dataSet: dataSet)
        
        pieChartView.holeRadiusPercent = 0.8
        pieChartView.holeColor = UIColor.clear // 배경색을 투명하게 설정
        
        pieChartView.data = data
        pieChartView.legend.enabled = false
    }
    private func loadImage() {
        guard let url = URL(string:"https://static.news.zumst.com/images/58/2023/10/23/0cb287d9a1e2447ea120fc5f3b0fcc11.jpg") else { return }
        cupidImageView.kf.setImage(with: url)
    }

}

//
//  GuideViewController.swift
//  YeonBa
//
//  Created by jin on 3/14/24.
//

import UIKit
import SnapKit
import Then

class GuideViewController: UIViewController {
    // MARK: - UI Components

    let instructionsTitle = UILabel().then {
        $0.text = "가이드를 꼭 준수해주세요."
        $0.font = UIFont.pretendardBold(size: 26)
        $0.textColor = .black
    }
    
    let instructionsLabel1 = UILabel().then {
        $0.text = "1.  꼭 본인 사진으로 등록해 주세요."
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textColor = .black
    }
    
    let instructionsLabel2 = UILabel().then {
        $0.text = "2. 내 얼굴이 잘 보이는 사진으로 업로드해 주세요."
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textColor = .black
    }
    
    let instructionsLabel3 = UILabel().then {
        $0.text = "3. 선글라스, 마스크 등으로 얼굴을 가리지 마세요."
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = UIFont.pretendardMedium(size: 16)
        $0.textColor = .black
    }
    
    let goodLabel = UILabel().then {
        $0.text = "좋은 예시"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 20)
        $0.textColor = UIColor.goodColor
    }
    let badLabel = UILabel().then {
        $0.text = "나쁜 예시"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = UIFont.pretendardSemiBold(size: 20)
        $0.textColor = UIColor.red
    }
    
    let GuideGoodImage1 = UIImageView().then {
        $0.image = UIImage(named: "GuideGoodImage1")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    let GuideGoodImage2 = UIImageView().then {
        $0.image = UIImage(named: "GuideGoodImage1")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let GoodIcon = UIImageView().then {
        $0.image = UIImage(named: "GoodIcon")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    let GoodIcon2 = UIImageView().then {
        $0.image = UIImage(named: "GoodIcon")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    let GuideBadImage1 = UIImageView().then {
        $0.image = UIImage(named: "GuideBadImage1")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    let GuideBadImage2 = UIImageView().then {
        $0.image = UIImage(named: "GuideBadImage1")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let BadIcon = UIImageView().then {
        $0.image = UIImage(named: "BadIcon")
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    let BadIcon2 = UIImageView().then {
        $0.image = UIImage(named: "BadIcon")
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    let understandButton = ActualGradientButton().then {
        $0.setTitle("이해했어요", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 16)
        $0.layer.cornerRadius = 25
        $0.layer.masksToBounds = true
        $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    //MARK: - Actions
    @objc func didTapButton() {
        let selectVC = PhotoSelectionViewController()
        navigationController?.pushViewController(selectVC, animated: true)
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        addSubViews()
        configUI()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "사진 등록 가이드"
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }

    // MARK: - UI Layout
    private func addSubViews() {
        [instructionsTitle, instructionsLabel1, instructionsLabel2, instructionsLabel3, goodLabel, GuideGoodImage1, GuideGoodImage2,GoodIcon, GoodIcon2, badLabel, GuideBadImage1, GuideBadImage2, BadIcon, BadIcon2, understandButton ].forEach {
            view.addSubview($0)
        }
    }
    private func configUI() {
        instructionsTitle.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        instructionsLabel1.snp.makeConstraints { make in
            make.top.equalTo(instructionsTitle.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        instructionsLabel2.snp.makeConstraints { make in
            make.top.equalTo(instructionsLabel1.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        instructionsLabel3.snp.makeConstraints { make in
            make.top.equalTo(instructionsLabel2.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        goodLabel.snp.makeConstraints{ make in
            make.top.equalTo(instructionsLabel3.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        GuideGoodImage1.snp.makeConstraints { make in
            make.top.equalTo(goodLabel.snp.bottom).offset(7)
            make.right.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(150)
            make.width.equalTo(172)
        }
        GuideGoodImage2.snp.makeConstraints { make in
            make.top.equalTo(goodLabel.snp.bottom).offset(7)
            make.left.equalTo(view.snp.centerX).offset(10)
            make.height.equalTo(150)
            make.width.equalTo(172)
        }
        GoodIcon.snp.makeConstraints{ make in
            make.top.equalTo(GuideGoodImage1.snp.bottom).offset(-17.5)
            make.centerX.equalTo(GuideGoodImage1.snp.centerX)
        }
        GoodIcon2.snp.makeConstraints{ make in
            make.top.equalTo(GuideGoodImage2.snp.bottom).offset(-17.5)
            make.centerX.equalTo(GuideGoodImage2.snp.centerX)
        }
        
        badLabel.snp.makeConstraints{make in
            make.top.equalTo(GuideGoodImage1.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        GuideBadImage1.snp.makeConstraints { make in
            make.top.equalTo(badLabel.snp.bottom).offset(7)
            make.right.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(150)
            make.width.equalTo(172)
        }
        
        GuideBadImage2.snp.makeConstraints { make in
            make.top.equalTo(badLabel.snp.bottom).offset(7)
            make.left.equalTo(view.snp.centerX).offset(10)
            make.height.equalTo(150)
            make.width.equalTo(172)
        }
        BadIcon.snp.makeConstraints{ make in
            make.top.equalTo(GuideBadImage1.snp.bottom).offset(-17.5)
            make.centerX.equalTo(GuideBadImage1.snp.centerX)
        }
        BadIcon2.snp.makeConstraints{ make in
            make.top.equalTo(GuideBadImage2.snp.bottom).offset(-17.5)
            make.centerX.equalTo(GuideBadImage2.snp.centerX)
        }
        
        understandButton.snp.makeConstraints { make in
            make.top.equalTo(GuideBadImage2.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
    }
}

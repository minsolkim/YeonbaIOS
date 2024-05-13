//
//  HomeCollectionViewCell.swift
//  YeonBa
//
//  Created by 김민솔 on 3/27/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import Charts
import Alamofire

class HomeCollectionViewCell: UICollectionViewCell {
    var id : String?
    static let sendCupidIdentifier = "HomeCupidCell"
    
    private let cupidImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    private let pieChartView = PieChartView() //유사도
    private let similarityLabel = UILabel().then {
        $0.text = "80%"
        $0.textColor = UIColor.primary
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 13.1)
    }
    private let nameLabel = UILabel().then {
        $0.text = "지은잉"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 18)
    }
    private let ageLabel = UILabel().then {
        $0.text = "27"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 16)
    }
    private let heartImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "Homeheart")
    }
    private let heartLabel = UILabel().then {
        $0.text = "315"
        $0.textColor = UIColor.primary
        $0.textAlignment = .center
        $0.font = UIFont.pretendardRegular(size: 13)
    }
    private let cupidFavoriteButton = UIButton().then {
        $0.setImage(UIImage(named: "WhiteFavorites"), for: .normal)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setUI()
        loadImage()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSubviews() {
        contentView.addSubview(cupidImageView)
        cupidImageView.addSubview(pieChartView)
        cupidImageView.addSubview(similarityLabel)
        cupidImageView.addSubview(nameLabel)
        cupidImageView.addSubview(ageLabel)
        cupidImageView.addSubview(heartImage)
        cupidImageView.addSubview(heartLabel)
        cupidImageView.addSubview(cupidFavoriteButton)
    }
    func setUI() {
        cupidImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        similarityLabel.snp.makeConstraints {
            $0.bottom.equalTo(cupidImageView.snp.bottom).offset(-30)
            $0.trailing.equalTo(cupidImageView.snp.trailing).offset(-24)
        }
        pieChartView.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(90)
            $0.bottom.equalToSuperview().inset(-5)
            $0.trailing.equalTo(cupidImageView.snp.trailing).offset(5)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(cupidImageView.snp.leading).offset(10)
            $0.top.equalTo(cupidImageView.snp.top).offset(132)
            
        }
        ageLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(nameLabel.snp.bottom)
        }
        heartImage.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        heartLabel.snp.makeConstraints {
            $0.leading.equalTo(heartImage.snp.trailing).offset(5)
            $0.top.equalTo(heartImage.snp.top)
        }
        cupidFavoriteButton.snp.makeConstraints {
            $0.width.equalTo(16)
            $0.height.equalTo(20)
            $0.trailing.equalTo(cupidImageView.snp.trailing).offset(-10)
            $0.top.equalTo(cupidImageView.snp.top).offset(10)
        }
    }
    func setupPieChart(pieValue: Int) {
        let entries = [PieChartDataEntry(value: Double(pieValue)), PieChartDataEntry(value: Double(100-pieValue))]

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
    /**
     * API 응답 구현체 값
     */
    struct AFDataResponse<T: Codable>: Codable {
        
        // 응답 결과값
        let data: T?
        
        // 응답 코드
        let status: String?
        
        // 응답 메시지
        let message: String?
        
        enum CodingKeys: CodingKey {
            case data, status, message
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            status = (try? values.decode(String.self, forKey: .status)) ?? nil
            message = (try? values.decode(String.self, forKey: .message)) ?? nil
            data = (try? values.decode(T.self, forKey: .data)) ?? nil
        }
    }
    func apiBookmark(id : String) -> Void{
        let url = "https://api.yeonba.co.kr/favorites/" + id;

        // Alamofire 를 통한 API 통신
        AF.request(
            url,
            method: .post,
            encoding: JSONEncoding.default)
        .validate(statusCode: 200..<500)
        .responseJSON{response in print(response)}
    }
    @objc func favoriteButtonTapped() {
        if let currentImage = cupidFavoriteButton.imageView?.image {
            if(currentImage == UIImage(named: "PinkFavorites")){
                let newImage = UIImage(named: "WhiteFavorites")
                cupidFavoriteButton.setImage(newImage, for: .normal)
                apiBookmark(id: id!)
            }
            else {
                let newImage = UIImage(named: "PinkFavorites")
                cupidFavoriteButton.setImage(newImage, for: .normal)
                apiBookmark(id: id!)
            }
        }
    }
    func configure(with model: CollectDataUserModel) {
        nameLabel.text = model.nickname
        heartLabel.text = "\(model.receivedArrows!)"
        similarityLabel.text = "\(model.photoSyncRate!)%"
        setupPieChart(pieValue: model.photoSyncRate!)
        id = model.id!
        //나이
        //ageLabel.text = "\(model.age)"
        // 이미지 로딩
        //if let url = URL(string: model.imageURL) {
        //    cupidImageView.kf.setImage(with: url)
        //}
    }
    private func loadImage() {
        guard let url = URL(string:"https://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2021/11/27/OGgTiLOGukOG637735761948231549.jpg") else { return }
        cupidImageView.kf.setImage(with: url)
    }
}

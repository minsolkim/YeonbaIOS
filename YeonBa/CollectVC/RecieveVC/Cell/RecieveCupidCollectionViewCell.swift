//
//  RecieveCupidCollectionViewCell.swift
//  YeonBa
//
//  Created by jin on 4/29/24.
//
import UIKit
import Then
import SnapKit
import Kingfisher
import Charts
import Alamofire

class RecieveCupidCollectionViewCell: UICollectionViewCell {
    var id : String?
    
    static let sendCupidIdentifier = "RecieveCell"
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
        $0.text = "츄랭이"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 18)
    }
    private let ageLabel = UILabel().then {
        $0.text = "22"
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
        $0.setImage(UIImage(named: "PinkFavorites"), for: .normal)
        $0.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
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
            $0.width.equalTo(85)
            $0.height.equalTo(85)
            $0.bottom.equalToSuperview().inset(-5)
            $0.trailing.equalTo(cupidImageView.snp.trailing).offset(5)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(cupidImageView.snp.leading).offset(10)
            $0.bottom.equalTo(heartImage.snp.top).offset(-5)
            
        }
        ageLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(5)
            $0.bottom.equalTo(nameLabel.snp.bottom)
        }
        heartImage.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(10)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        heartLabel.snp.makeConstraints {
            $0.leading.equalTo(heartImage.snp.trailing).offset(5)
            $0.bottom.equalToSuperview().inset(10)
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
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // 터치된 지점이 버튼의 영역 안에 있는지 확인
        let buttonPoint = convert(point, to: cupidFavoriteButton)
        if cupidFavoriteButton.bounds.contains(buttonPoint) {
            // 버튼의 영역 안이면 버튼을 반환하여 버튼의 터치 이벤트만 처리하도록 함
            return cupidFavoriteButton
        }
        // 버튼의 영역 밖이면 기존 동작을 유지하도록 함
        return super.hitTest(point, with: event)
    }
    private func loadImage() {
        guard let url = URL(string:"https://static.news.zumst.com/images/58/2023/10/23/0cb287d9a1e2447ea120fc5f3b0fcc11.jpg") else { return }
        cupidImageView.kf.setImage(with: url)
    }
    
}

//
//  HomeViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 2/29/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher
import Charts
import SCLAlertView
import Alamofire

class HomeViewController: UIViewController {
    var colletModel : [CollectDataUserModel]?
    // MARK: - UI Components
    //스크롤 뷰
    let heartCountLabel = UILabel()
    private let mainScrollview = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let recommendTitle = UILabel().then {
        $0.text = "회원님을 위한 추천 이성"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 16)
    }
    //테이블 뷰
    private let tableView =  UITableView().then {
        $0.allowsSelection = true //셀 클릭이 가능하게 하는거
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.identifier)
    }
    private let recommendButton = ActualGradientButton().then {
        $0.setTitle("새로운 추천 이성", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardSemiBold(size: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 22
        $0.layer.masksToBounds = true
        let image = UIImage(named: "Replay")
        $0.setImage(image, for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    private let barView = UIView().then {
        $0.layer.backgroundColor = UIColor.init(named: "gray")?.cgColor
    }
    private let cupidGenderLabel = UILabel().then {
        $0.text = "최근에 화살을 보낸 이성"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.font = UIFont.pretendardSemiBold(size: 16)
    }
    private let plusGenderButton = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendardRegular(size: 13)
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.addTarget(self, action: #selector(plusGenderTapped), for: .touchUpInside)
    }
    private lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
            $0.clipsToBounds = true
        }
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        configUI()
        checkfont()
        setupNavigationBar()
        configureTableView()
        configureCollectionView()
        apiDailyCheck()
        apiRecieveList()
        apiGetArrowCount()
        tableView.reloadData()
    }
    // MARK: - Navigation
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let titleLabel = UILabel()
        titleLabel.text = "Yeonba"
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.hidesBackButton = true
        let heartButton = UIBarButtonItem(image: UIImage(named: "Heart"), style: .plain, target: self, action: #selector(heartButtonTapped))
        
        heartCountLabel.text = "5" // 초기 하트 개수
        heartCountLabel.textColor = UIColor.primary
        heartCountLabel.sizeToFit()
        let heartCountBarButton = UIBarButtonItem(customView: heartCountLabel)
        
        let alarmButton = UIBarButtonItem(image: UIImage(named: "Alarm"), style: .plain, target: self, action: #selector(alarmButtonTapped))
        
        navigationItem.rightBarButtonItems = [alarmButton, heartCountBarButton, heartButton]
        
    }
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    func configureCollectionView() {
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCupidCell")
    }
    // MARK: - UI Layout
    func addSubviews() {
        view.addSubview(mainScrollview)
        mainScrollview.addSubview(contentView)
        contentView.addSubview(recommendTitle)
        contentView.addSubview(tableView)
        contentView.addSubview(recommendButton)
        contentView.addSubview(barView)
        contentView.addSubview(cupidGenderLabel)
        contentView.addSubview(plusGenderButton)
        contentView.addSubview(collectionview)
    }
    
    func configUI() {
        mainScrollview.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top) // 네비게이션 바 아래부터 시작하고 40의 마진을 두도록 설정
            $0.leading.trailing.bottom.equalToSuperview() // 나머지 영역은 부모 뷰와 같도록 설정
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(800)
            $0.top.bottom.equalToSuperview()
        }
        recommendTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(30)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(recommendTitle.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(320)
        }
        recommendButton.snp.makeConstraints {
            $0.width.equalTo(163)
            $0.height.equalTo(43)
            $0.top.equalTo(tableView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        barView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(recommendButton.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        cupidGenderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(barView.snp.bottom).offset(20)
        }
        plusGenderButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(cupidGenderLabel.snp.bottom).offset(6)
        }
        collectionview.snp.makeConstraints {
            $0.top.equalTo(cupidGenderLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(200)
        }
        
        
    }
    func checkfont() {
        for family in UIFont.familyNames {
            print(family)
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
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
    func apiRecieveList() -> Void{
        let url = "https://api.yeonba.co.kr/users?type=RECOMMEND&page=0&size=2";

        // Alamofire 를 통한 API 통신
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default)
        .validate(statusCode: 200..<500)
        //.responseJSON{response in print(response)}
        .responseDecodable(of: AFDataResponse<CollectResponse>.self) { response in
            switch response.result {
                // [CASE] API 통신에 성공한 경우
            case .success(let value):
                print("성공하였습니다 :: \(value)")
                if let users = value.data?.data?.users, !users.isEmpty {
                    // 유저 데이터가 존재하는 경우
                    self.colletModel = users
                    self.addSubviews()
                    self.configUI()
                    self.collectionview.dataSource = self
                    self.collectionview.delegate = self
                    self.collectionview.register(RecieveCupidCollectionViewCell.self, forCellWithReuseIdentifier: "RecieveCell")
                }
                // [CASE] API 통신에 실패한 경우
            case .failure(let error):
                print("실패하였습니다 :: \(error)" )
            }
        }
    }
    func apiGetArrowCount() -> Void{
        let url = "https://api.yeonba.co.kr/users/arrows";

        // Alamofire 를 통한 API 통신
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default)
        .validate(statusCode: 200..<500)
        //.responseJSON{response in print(response)}
        .responseDecodable(of: AFDataResponse<HomeAPIResponse>.self) { response in
            switch response.result {
                // [CASE] API 통신에 성공한 경우
            case .success(let value):
                print("성공하였습니다 :: \(value)")
                if let arrow = value.data?.data?.arrows{
                    self.heartCountLabel.text = "\(arrow)"
                }
                // [CASE] API 통신에 실패한 경우
            case .failure(let error):
                print("실패하였습니다 :: \(error)" )
            }
        }
    }
    func apiDailyCheck() -> Void{
        let url = "https://api.yeonba.co.kr/daily-check";

        // Alamofire 를 통한 API 통신
        AF.request(
            url,
            method: .post,
            encoding: JSONEncoding.default)
        .validate(statusCode: 200..<500)
        .responseJSON{response in print(response)}
    }
    // MARK: - Actions
    @objc func heartButtonTapped() {
        print("heart button tapped")
    }
    @objc func alarmButtonTapped() {
        self.navigationController?.pushViewController(NotificationsViewController(), animated: true)
    }
    @objc func didTapButton() {
        let alertView = SCLAlertView()
        alertView.iconTintColor = .primary
        alertView.addButton("확인", backgroundColor: .primary, textColor: .white) {
            
        }
        alertView.showTitle(
            "다시해보기",
            subTitle: "새로 고침시 5개의 화살이 소진 됩니다. 새로운 추천 이성을 확인해 볼까요?",
            style: .notice,
            closeButtonTitle: "취소"
        )
    }
    @objc func plusGenderTapped() {
        //self.navigationController?.pushViewController(CollectViewController(), animated: true)
    }
    
    
}
extension UIFont {
    static func pretendardSemiBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Pretendard-SemiBold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        return font
    }
    static func pretendardRegular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Pretendard-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
}
extension UIButton {
    func adjustBorderWidth() {
        guard let title = self.titleLabel?.text else {
            return
        }
        let titleSize = title.size(withAttributes: [.font: self.titleLabel!.font!])
        let buttonWidth = titleSize.width + 20 // 여유 공간을 더하여 버튼의 너비 계산
        let buttonHeight = titleSize.height + 20 // 여유 공간을 더하여 버튼의 높이 계산
        self.frame.size = CGSize(width: buttonWidth, height: buttonHeight) // 버튼의 크기를 조절
        self.layer.borderWidth = 1 // 테두리의 너비를 1로 설정
    }
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  colletModel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendTableViewCell.identifier, for: indexPath) as? RecommendTableViewCell else {
            return UITableViewCell()
        }
        // colletModel 배열의 indexPath.row에 해당하는 모델을 가져와서 셀에 전달
        let model = colletModel?[indexPath.row]
        cell.configure(with: model ??  CollectDataUserModel(id: "12", nickname: "존잘남", receivedArrows: 11, lookAlikeAnimal: "강아지상", photoSyncRate: 80, activityArea: "서울", height: 180, vocalRange: "저음"))
        return cell
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let otherProfileVC = OtherProfileViewController()
        otherProfileVC.id = colletModel![indexPath.row].id
        self.navigationController?.pushViewController(otherProfileVC, animated: true)
    }
}
extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return colletModel?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 셀을 dequeue 하고, SendCupidCollectionViewCell 타입으로 타입 캐스팅합니다.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCupidCell", for: indexPath) as? HomeCollectionViewCell else {
            // 캐스팅에 실패하면 기본 UICollectionViewCell을 반환합니다.
            return UICollectionViewCell()
        }
        // colletModel 배열의 indexPath.row에 해당하는 모델을 가져와서 셀에 전달
        let model = colletModel?[indexPath.row]
        cell.configure(with: model ??  CollectDataUserModel(id: "12", nickname: "존잘남", receivedArrows: 11, lookAlikeAnimal: "강아지상", photoSyncRate: 80, activityArea: "서울", height: 180, vocalRange: "저음"))
        return cell
    }
    
    
}

extension HomeViewController : UICollectionViewDelegate {
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

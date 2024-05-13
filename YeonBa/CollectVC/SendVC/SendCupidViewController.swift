//
//  SendCupidViewController.swift
//  YeonBa
//
//  Created by 김민솔 on 3/10/24.
//

import UIKit
import Then
import SnapKit
import Alamofire

class SendCupidViewController: UIViewController {
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
    func apiSentList() -> Void{
        let url = "https://api.yeonba.co.kr/users?type=SENT_ARROWS&page=0&size=6";
        // Alamofire 를 통한 API 통신
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default
        )
        .validate(statusCode: 200..<500)
        //.responseJSON{response in print(response)}
        .responseDecodable(of: AFDataResponse<CollectResponse>.self) { response in
            switch response.result {
                // [CASE] API 통신에 성공한 경우
            case .success(let value):
                print("성공하였습니다 :: \(value)")
                // [CASE] API 통신에 실패한 경우
            case .failure(let error):
                print("실패하였습니다 :: \(error)" )
            }
        }
    }
    let colletModel : [CollectDataUserModel] = [
        CollectDataUserModel(id: "1", nickname: "존잘남", receivedArrows: 11, lookAlikeAnimal: "강아지상", photoSyncRate: 80, activityArea: "서울", height: 180, vocalRange: "저음"),
        CollectDataUserModel(id: "12", nickname: "존잘남", receivedArrows: 11, lookAlikeAnimal: "강아지상", photoSyncRate: 80, activityArea: "서울", height: 180, vocalRange: "저음"),
        CollectDataUserModel(id: "12", nickname: "존잘남", receivedArrows: 11, lookAlikeAnimal: "강아지상", photoSyncRate: 80, activityArea: "서울", height: 180, vocalRange: "저음")]
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
        addSubviews()
        configUI()
        initialize()
        apiSentList()
       
    }
    func initialize() {
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(SendCupidCollectionViewCell.self, forCellWithReuseIdentifier: "SendCupidCell")
    }
    func addSubviews() {
        view.addSubview(collectionview)
    }
    func configUI() {
        collectionview.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
    }

}
extension SendCupidViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return colletModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SendCupidCell", for: indexPath) as? SendCupidCollectionViewCell else {
            return UICollectionViewCell()
        }
        // colletModel 배열의 indexPath.row에 해당하는 모델을 가져와서 셀에 전달
        let model = colletModel[indexPath.row]
        cell.configure(with: model)
        return cell    }
}
extension SendCupidViewController : UICollectionViewDelegate {
    //셀 클릭 시 이동
    func collectionView(_ collectionview: UICollectionView, didSelectItemAt indexPath : IndexPath) {
        let otherProfileVC = OtherProfileViewController()
        otherProfileVC.id = colletModel[indexPath.row].id
        self.navigationController?.pushViewController(otherProfileVC, animated: true)
    }
}
extension SendCupidViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 5
        let width = (collectionView.bounds.width - 8 - 8 - spacing) / 2 // 총 가로길이 - leading - trailing - 간격
        let height = (collectionView.bounds.height - 60 - spacing * 2) / 3 // 총 세로길이 - top - bottom - 간격
        return CGSize(width: width, height: height)
    }
}

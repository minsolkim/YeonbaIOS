import UIKit
import SnapKit
import Then

// 내가 보낸 메시지 셀
class MyMessageCell: UITableViewCell {
    //MARK: - UI Components
    let messageLabel = UILabel().then {
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.backgroundColor = .clear
        $0.font = UIFont.pretendardMedium(size: 16)
    }

    let messageBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.gray2
        $0.layer.masksToBounds = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        configUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradientBackground()
        messageBackgroundView.roundCorners(leftTop: 20, rightTop: 4, leftBottom: 20, rightBottom: 20)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "FF8F96").cgColor,
            UIColor(hex: "FF2149").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = messageBackgroundView.bounds
        
        // 기존 그라데이션 레이어 제거 (레이아웃 업데이트 시 중복 추가 방지)
        messageBackgroundView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        // 그라데이션 레이어 추가
        messageBackgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: - UI Layout
    private func addSubView(){
        contentView.addSubview(messageBackgroundView)
        messageBackgroundView.addSubview(messageLabel)
    }

    private func configUI() {
        messageBackgroundView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.lessThanOrEqualTo(296)
        }
               
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }

    }
}
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

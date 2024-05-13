import UIKit
import SnapKit
import Then

// 상대방이 보낸 메시지 셀
class OtherMessageCell: UITableViewCell {
    //MARK: - UI Components
    let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    let messageLabel = UILabel().then {
        $0.textColor = .black
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
        addSubview()
        configUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        messageBackgroundView.roundCorners(leftTop: 4, rightTop: 20, leftBottom: 20, rightBottom: 20)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - UI Layout
    private func addSubview(){
        contentView.addSubview(profileImageView)
        contentView.addSubview(messageBackgroundView)
        messageBackgroundView.addSubview(messageLabel)
    }
    private func configUI() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.width.height.equalTo(30)
        }
        messageBackgroundView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.lessThanOrEqualTo(296)
        }
               
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }

    }
}
extension UIBezierPath {
    convenience init(for bounds: CGRect, leftTopSize: CGSize = .zero, rightTopSize: CGSize = .zero, leftBottomSize: CGSize = .zero, rightBottomSize: CGSize = .zero) {
        self.init()

        let path = CGMutablePath()

        let leftTop: CGPoint = bounds.origin
        let rightTop: CGPoint = CGPoint(x: bounds.maxX, y: bounds.minY)
        let leftBottom: CGPoint = CGPoint(x: bounds.minX, y: bounds.maxY)
        let rightBottom: CGPoint = CGPoint(x: bounds.maxX, y: bounds.maxY)

        if leftTopSize != .zero {
            // 1️⃣
            path.move(to: CGPoint(x: leftTop.x + leftTopSize.width, y: leftTop.y))
        } else {
            path.move(to: leftTop)
        }

        // path가 그려지는 순서가 leftTop -> rightTop -> rightBottom -> leftBottom -> leftTop 이므로 아래 조건문 순서가 바뀌어서는 안됩니다.
        if rightTopSize != .zero {
            // 2️⃣
            path.addLine(to: CGPoint(x: rightTop.x - rightTopSize.width, y: rightTop.y))
            // 3️⃣
            path.addCurve(to: CGPoint(x: rightTop.x, y: rightTop.y + rightTopSize.height), control1: CGPoint(x: rightTop.x, y: rightTop.y), control2: CGPoint(x: rightTop.x, y: rightTop.y + rightTopSize.height))
        } else {
            path.addLine(to: rightTop)
        }

        if rightBottomSize != .zero {
            // 4️⃣
            path.addLine(to: CGPoint(x: rightBottom.x, y: rightBottom.y - rightBottomSize.height))
            // 5️⃣
            path.addCurve(to: CGPoint(x: rightBottom.x - rightBottomSize.width, y: rightBottom.y), control1: CGPoint(x: rightBottom.x, y: rightBottom.y), control2: CGPoint(x: rightBottom.x - rightBottomSize.width, y: rightBottom.y))
        } else {
            path.addLine(to: rightBottom)
        }

        if leftBottomSize != .zero {
            // 6️⃣
            path.addLine(to: CGPoint(x: leftBottom.x + leftBottomSize.width, y: leftBottom.y))
            // 7️⃣
            path.addCurve(to: CGPoint(x: leftBottom.x, y: leftBottom.y - leftBottomSize.height), control1: CGPoint(x: leftBottom.x, y: leftBottom.y), control2: CGPoint(x: leftBottom.x, y: leftBottom.y - leftBottomSize.height))
        } else {
            path.addLine(to: leftBottom)
        }

        if leftTopSize != .zero {
            // 8️⃣
            path.addLine(to: CGPoint(x: leftTop.x, y: leftTop.y + leftTopSize.height))
            // 9️⃣
            path.addCurve(to: CGPoint(x: leftTop.x + leftTopSize.width, y: leftTop.y), control1: CGPoint(x: leftTop.x, y: leftTop.y), control2: CGPoint(x: leftTop.x + leftTopSize.width, y: leftTop.y))
        } else {
            path.addLine(to: leftTop)
        }

        path.closeSubpath()
        cgPath = path
    }
}
extension UIView {
    func roundCorners(leftTop: CGFloat = 0, rightTop: CGFloat = 0, leftBottom: CGFloat = 0, rightBottom: CGFloat = 0) {
        let leftTopSize = CGSize(width: leftTop, height: leftTop)
        let rightTopSize = CGSize(width: rightTop, height: rightTop)
        let leftBottomSize = CGSize(width: leftBottom, height: leftBottom)
        let rightBottomSize = CGSize(width: rightBottom, height: rightBottom)
        let maskedPath = UIBezierPath(for: self.bounds, leftTopSize: leftTopSize, rightTopSize: rightTopSize, leftBottomSize: leftBottomSize, rightBottomSize: rightBottomSize)

        let shape = CAShapeLayer()
        shape.path = maskedPath.cgPath
        self.layer.mask = shape
    }
}

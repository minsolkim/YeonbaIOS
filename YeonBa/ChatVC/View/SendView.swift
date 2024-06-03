//
//  SendView.swift
//  YeonBa
//
//  Created by 김민솔 on 5/15/24.
//

import Foundation
import UIKit
import SnapKit
import Then

final class SendView : UIView {
    private let messageTextField = UITextField().then {
        $0.placeholder = "메시지 보내기"
        $0.borderStyle = .none
        $0.backgroundColor = .gray2
        $0.textColor = .customgray4
        $0.font = UIFont.pretendardRegular(size: 13)
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.textAlignment = .left
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)) // sendButton의 width와 동일하게 설정
        $0.rightViewMode = .always
    }
    private let sendButton = UIButton().then {
        $0.setImage(UIImage(named: "SendIcon"), for: .normal) // 전송 아이콘 이미지 설정
        $0.contentMode = .scaleAspectFit
    }
    
    init() {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
        addSubviews(messageTextField,sendButton)
    }
    
    func setLayout() {
        messageTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalTo(messageTextField.snp.centerY)
            make.width.height.equalTo(20) // 아이콘 크기
        }
    }
    
}


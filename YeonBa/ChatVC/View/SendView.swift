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
import StompClientLib

protocol SendViewDelegate: AnyObject {
    func didSendMessage(_ message: ChatMessage)
    func didReceiveMessage(_ message: ChatRoomResonse)
}

final class SendView: UIView {
    var roomId: Int?
    weak var delegate: SendViewDelegate?
    //weak var chatdelegate: ChatMessageDelegate?
    private var socketClient = StompClientLib()
    private var messages: [ChatMessage] = []
    private var socketURL: NSURL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "WebSocketURL") as? String,
              let url = NSURL(string: urlString) else {
            fatalError("WebSocket URL is not configured correctly in info.plist")
        }
        return url
    }
    private var messageDestinationURL: String {
        return "/chat/pub/chat"
    }
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
        $0.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    init(roomId: Int?) {
        self.roomId = roomId
        super.init(frame: .zero)
        setUI()
        setLayout()
        print("룸아이디:\(roomId ?? 0)")
        connectToWebSocket()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubviews(messageTextField, sendButton)
    }
    
    func setLayout() {
        messageTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalTo(messageTextField.snp.centerY)
            make.width.height.equalTo(20) // 아이콘 크기
        }
    }
    
    func connectToWebSocket() {
        let accessToken = KeychainHandler.shared.accessToken
        
        var request = URLRequest(url: socketURL as URL)
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        print("Connecting to WebSocket with URL: \(socketURL.absoluteString)")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        socketClient.openSocketWithURLRequest(request: request as NSURLRequest, delegate: self)
    }
    @objc func sendMessage() {
        guard let message = messageTextField.text, !message.isEmpty else {
            return
        }
        
        let userId = KeychainHandler.shared.kakaoUserID
        let userName = SignDataManager.shared.nickName
        let sentAt = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            $0.timeZone = TimeZone(secondsFromGMT: 0)
        }.string(from: Date())
        
        let request: [String: Any] = [
            "roomId": roomId ?? 0,
            "userId": userId,
            "userName": userName ?? "민솔",
            "content": message,
            "sentAt": ISO8601DateFormatter().string(from: Date())
        ]
        let messageObject = ChatMessage(content: message, userId: userId, sentAt: sentAt, userName: userName ?? "민솔")
        delegate?.didSendMessage(messageObject)
        print("request 값: \(request)")
        print("전송할 메시지: \(messageObject)")
        socketClient.sendJSONForDict(dict: request as AnyObject, toDestination: messageDestinationURL)
        messageTextField.text = ""
    }
    func showMessageOutput(userId: Int, userName: String, message: String, sentAt: String) {
        let newMessage = ChatRoomResonse(userId: userId, userName: userName, content: message, sentAt: sentAt)
        delegate?.didReceiveMessage(newMessage)
        print(newMessage)
        
    }
}

extension SendView: StompClientLibDelegate {
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        guard let body = jsonBody as? [String: Any],
              let userId = body["userId"] as? Int,
              let userName = body["userName"] as? String,
              let content = body["content"] as? String,
              let sentAt = body["sentAt"] as? String else {
            print("Error parsing JSON message")
            return
        }
        print("jsonBody: \(String(describing: jsonBody))")
        showMessageOutput(userId: userId, userName: userName, message: content, sentAt: sentAt)
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("StompClient is connected")
        guard let roomId = roomId else {
            print("roomId is nil")
            return
        }
        
        let topic = "/chat/sub/room/\(roomId)"
        print("Subscribing to topic: \(topic)")
        client.subscribe(destination: topic)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("StompClient is disconnected")
    }
    
    func stompClientDidReceiveError(client: StompClientLib!, withErrorMessage description: String) {
        print("Received error: \(description)")
    }
    
    func stompClientError(_ client: StompClientLib!, didReceiveErrorMessage description: String) {
        print("StompClient received error: \(description)")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("StompClient received receipt: \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("StompClient received error message: \(description)")
    }
    
    func serverDidSendPing() {
        print("StompClient received ping")
    }
}



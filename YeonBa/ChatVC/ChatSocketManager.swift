//
//  ChatSocketManager.swift
//  YeonBa
//
//  Created by 김민솔 on 5/19/24.
//

import Foundation
import SocketIO

class ChatSocketManager {
    static let shared = ChatSocketManager()
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    private init() {
        manager = SocketManager(socketURL: URL(string: "https://api.yeonba.co.kr")!,config: [.log(true), .compress])
        socket = manager.defaultSocket
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func joinChat(chatId: Int) {
       // socket.emit("join", with: [chatId], completion: <#(() -> ())?#>)
    }
    
    func sendMessage(chatId: Int, message: String) {
        let messageData : [String: Any] = ["chatId": chatId, "message": message]
      //  socket.emit("message", with: [messageData], completion: <#(() -> ())?#>)
    }
    
    func receiveMessage(completion: @escaping (String) -> Void) {
        socket.on("message") { dataArray, ack in
            if let message = dataArray[0] as? String {
                completion(message)
            }
        }
    }
}

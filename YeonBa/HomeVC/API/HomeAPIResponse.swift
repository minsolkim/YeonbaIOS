//
//  HomeAPIResponse.swift
//  YeonBa
//
//  Created by jin on 5/13/24.
//

import Foundation

struct HomeAPIResponse : Codable {
    let status: String?
    let message: String?
    let data: Arrows?
    
    enum CodingKeys: CodingKey {
        case status, message, data
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(String.self, forKey: .status)) ?? nil
        message = (try? values.decode(String.self, forKey: .message)) ?? nil
        data = (try? values.decode(Arrows.self, forKey: .data)) ?? nil
    }
    
}

struct Arrows {
    let arrows: Int?
}
extension Arrows: Codable {
    enum CodingKeys: String, CodingKey {
        case arrows
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        arrows = try container.decode(Int.self, forKey: .arrows)
    }
}

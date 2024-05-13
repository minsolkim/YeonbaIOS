//
//  CollectModel.swift
//  YeonBa
//
//  Created by jin on 4/29/24.
//

import Foundation
struct CollectResponse : Codable{
    
    let status : String?
    let message : String?
    let data : CollectDataModel?
    
    
    
    enum CodingKeys: CodingKey {
        case status, message, data
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(String.self, forKey: .status)) ?? nil
        message = (try? values.decode(String.self, forKey: .message)) ?? nil
        data = (try? values.decode(CollectDataModel.self, forKey: .data)) ?? nil
    }
}

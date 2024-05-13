//
//  OtherProfileDataModel.swift
//  YeonBa
//
//  Created by jin on 4/29/24.
//

import Foundation
struct OtherProfileDataModel : Codable{
    let profilePhotosUrls: [String]?
    let gender : String?
    let nickname: String?
    let arrows: Int?
    let age : Int?
    let lookAlikeAnimal: String?
    let photoSyncRate: Double?
    let activityArea: String?
    let height: Int?
    let vocalRange: String?
    let alreadySentArrow : Bool?
    /*
    enum CodingKeys: CodingKey {
        case id, nickname, receivedArrows, lookAlikeAnimal, photoSyncRate, activityArea, height, vocalRange
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(String.self, forKey: .id)) ?? nil
        nickname = (try? values.decode(String.self, forKey: .nickname)) ?? nil
        receivedArrows = (try? values.decode(Int.self, forKey: .receivedArrows)) ?? nil
        lookAlikeAnimal = (try? values.decode(String.self, forKey: .lookAlikeAnimal)) ?? nil
        photoSyncRate = (try? values.decode(Int.self, forKey: .photoSyncRate)) ?? nil
        activityArea = (try? values.decode(String.self, forKey: .activityArea)) ?? nil
        height = (try? values.decode(Int.self, forKey: .height)) ?? nil
        vocalRange = (try? values.decode(String.self, forKey: .vocalRange)) ?? nil
    }*/
   
}

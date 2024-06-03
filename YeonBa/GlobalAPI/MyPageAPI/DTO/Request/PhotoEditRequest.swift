//
//  PhotoEditRequest.swift
//  YeonBa
//
//  Created by jin on 5/30/24.
//

import Foundation

struct PhotoEditRequest: Codable {
    var profilePhotos : [Data]
    var photoSyncRate : Int
}

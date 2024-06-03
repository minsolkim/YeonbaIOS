//
//  FaceSimilarityResponse.swift
//  YeonBa
//
//  Created by jin on 5/7/24.
//

import Foundation

// 응답 데이터를 처리할 구조체 정의
struct FaceComparisonResult {
    let confidence: Double?
    let face1: [Face]
    let face2: [Face]
    let image_id1: String
    let image_id2: String
    let request_id: String
    let thresholds: Thresholds?
    let time_used: Int
}

struct Face {
    let face_rectangle: FaceRectangle?
    let face_token: String?
}

struct FaceRectangle {
    let height: Int
    let left: Int
    let top: Int
    let width: Int
}

struct Thresholds {
    let oneE3: Double
    let oneE4: Double
    let oneE5: Double
}

// JSON 디코딩을 위한 extension 추가
extension FaceComparisonResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case confidence, faces1, faces2, image_id1, image_id2, request_id, thresholds, time_used
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        confidence = (try? container.decode(Double.self, forKey: .confidence)) ?? 0.0
        image_id1 = try container.decode(String.self, forKey: .image_id1)
        image_id2 = try container.decode(String.self, forKey: .image_id2)
        request_id = try container.decode(String.self, forKey: .request_id)
        time_used = try container.decode(Int.self, forKey: .time_used)
        let faces1 = try container.decode([Face].self, forKey: .faces1)
        face1 = faces1
        let faces2 = try container.decode([Face].self, forKey: .faces2)
        face2 = faces2
        thresholds = (try? container.decode(Thresholds.self, forKey: .thresholds)) ?? Thresholds(oneE3: 0.0, oneE4: 0.0, oneE5: 0.0)
    }
}

extension Face: Decodable {
    enum CodingKeys: String, CodingKey {
        case face_rectangle, face_token
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        face_token = try container.decode(String.self, forKey: .face_token)
        face_rectangle = try container.decode(FaceRectangle.self, forKey: .face_rectangle)
    }
}

extension FaceRectangle: Decodable {
    enum CodingKeys: String, CodingKey {
        case height, left, top, width
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        height = try container.decode(Int.self, forKey: .height)
        left = try container.decode(Int.self, forKey: .left)
        top = try container.decode(Int.self, forKey: .top)
        width = try container.decode(Int.self, forKey: .width)
    }
}

extension Thresholds: Decodable {
    enum CodingKeys: String, CodingKey {
        case oneE3 = "1e-3", oneE4 = "1e-4", oneE5 = "1e-5"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        oneE3 = try container.decode(Double.self, forKey: .oneE3)
        oneE4 = try container.decode(Double.self, forKey: .oneE4)
        oneE5 = try container.decode(Double.self, forKey: .oneE5)
    }
}

// JSON 데이터를 위한 응답 파싱 함수
func parseResponse(data: Data) throws -> FaceComparisonResult {
    return try JSONDecoder().decode(FaceComparisonResult.self, from: data)
}

//
//  FactsResponseModel.swift
//  IOSProficiencyExercise
//
//  Created by Jaydip Godhani on 13/06/21.
//

import Foundation

// MARK: - FactsResponseModel
struct FactsResponseModel: Codable {
    let title: String
    let facts: [Facts]

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case facts = "rows"
    }
}

// MARK: - FactsRow
struct Facts: Codable {
    let title: String?
    let rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rowDescription = "description"
        case imageHref = "imageHref"
    }
}

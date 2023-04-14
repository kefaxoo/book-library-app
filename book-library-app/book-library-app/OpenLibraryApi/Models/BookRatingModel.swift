//
//  BookRatingModel.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import Foundation
import ObjectMapper

final class BookRatingModel: Mappable {
    var rating = 0.0
    
    init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        rating <- map["summary.average"]
    }
}

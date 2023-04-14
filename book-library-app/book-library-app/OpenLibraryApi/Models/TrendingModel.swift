//
//  TrendingModel.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import Foundation
import ObjectMapper

final class TrendingModel: Mappable {
    var books = [BookModel]()
    
    init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        books <- map["works"]
    }
}

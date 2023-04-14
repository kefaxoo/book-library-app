//
//  BookModel.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import Foundation
import ObjectMapper

final class BookModel: Mappable {
    var key = ""
    var title = ""
    var description: String?
    var firstPublishYear = 0
    var coverKey: String?
    
    init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        key              <- map["key"]
        title            <- map["title"]
        description      <- map["description"]
        firstPublishYear <- map["first_publish_year"]
        coverKey         <- map["lending_edition_s"]
    }
}

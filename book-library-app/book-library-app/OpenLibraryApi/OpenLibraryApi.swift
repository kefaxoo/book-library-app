//
//  OpenLibraryApi.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import Foundation
import Moya

enum OpenLibraryApi {
    case getTrendingBooks
    case getBookInfo(bookKey: String)
    case getBookRating(bookKey: String)
}

extension OpenLibraryApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://openlibrary.org")!
    }
    
    var path: String {
        switch self {
            case .getTrendingBooks:
                return "/trending/daily.json"
            case .getBookInfo(let bookKey):
                return "/\(bookKey).json"
            case .getBookRating(let bookKey):
                return "/\(bookKey)/ratings.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
            default:
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        var parameters = [String: Any]()
        switch self {
            case .getTrendingBooks:
                parameters["limit"] = 20
            default:
                return nil
        }
        
        return parameters
    }
    
    var encoding: URLEncoding {
        switch self {
            default:
                return .queryString
        }
    }
}

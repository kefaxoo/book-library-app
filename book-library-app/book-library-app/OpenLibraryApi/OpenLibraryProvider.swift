//
//  OpenLibraryProvider.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import Foundation
import Moya
import Moya_ObjectMapper

final class OpenLibraryProvider {
    static var shared = OpenLibraryProvider()
    
    private init() {}
    
    private let provider = MoyaProvider<OpenLibraryApi>(plugins: [NetworkLoggerPlugin()])
    
    func getTrendingBooks(success: @escaping (([BookModel]) -> ()), failure: (() -> ())? = nil) {
        provider.request(.getTrendingBooks) { result in
            switch result {
                case .success(let response):
                    guard let response = try? response.mapObject(TrendingModel.self) else {
                        failure?()
                        return
                    }
                    
                    success(response.books)
                case .failure(let error):
                    failure?()
            }
        }
    }
    
    func getBookInfo(bookKey: String, success: @escaping((BookModel) -> ()), failure: (() -> ())? = nil) {
        provider.request(.getBookInfo(bookKey: bookKey)) { result in
            switch result {
                case .success(let response):
                    guard let book = try? response.mapObject(BookModel.self) else {
                        failure?()
                        return
                    }
                    
                    success(book)
                case .failure(let error):
                    failure?()
            }
        }
    }
    
    func getBookRatings(bookKey: String, success: @escaping((Double) -> ()), failure: (() -> ())? = nil) {
        provider.request(.getBookRating(bookKey: bookKey)) { result in
            switch result {
                case .success(let response):
                    guard let rating = try? response.mapObject(BookRatingModel.self) else {
                        failure?()
                        return
                    }
                    
                    success(rating.rating)
                case .failure(let error):
                    failure?()
            }
        }
    }
}

//
//  OpenLibraryProvider.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import Foundation
import Moya
import Moya_ObjectMapper
import SPIndicator

final class OpenLibraryProvider {
    static var shared = OpenLibraryProvider()
    
    private init() {}
    
    private let provider = MoyaProvider<OpenLibraryApi>(plugins: [NetworkLoggerPlugin()])
    
    func getTrendingBooks(success: @escaping (([BookModel]) -> ())) {
        provider.request(.getTrendingBooks) { result in
            switch result {
                case .success(let response):
                    guard let response = try? response.mapObject(TrendingModel.self) else {
                        SPIndicator.present(title: "Error", message: "Fail while mapping object", haptic: .error, from: .top)
                        return
                    }
                    
                    success(response.books)
                case .failure(let error):
                    SPIndicator.present(title: "Error", message: error.localizedDescription, haptic: .error, from: .top)
            }
        }
    }
    
    func getBookInfo(bookKey: String, success: @escaping((BookModel) -> ())) {
        provider.request(.getBookInfo(bookKey: bookKey)) { result in
            switch result {
                case .success(let response):
                    guard let book = try? response.mapObject(BookModel.self) else {
                        SPIndicator.present(title: "Error", message: "Fail while mapping object", haptic: .error, from: .top)
                        return
                    }
                    
                    success(book)
                case .failure(let error):
                    SPIndicator.present(title: "Error", message: error.localizedDescription, haptic: .error, from: .top)
            }
        }
    }
    
    func getBookRatings(bookKey: String, success: @escaping((Double) -> ()), failure: (() -> ())? = nil) {
        provider.request(.getBookRating(bookKey: bookKey)) { result in
            switch result {
                case .success(let response):
                    guard let rating = try? response.mapObject(BookRatingModel.self) else {
                        SPIndicator.present(title: "Error", message: "Fail while mapping object", haptic: .error, from: .top)
                        return
                    }
                    
                    success(rating.rating)
                case .failure (let error):
                    SPIndicator.present(title: "Error", message: error.localizedDescription, haptic: .error, from: .top)
            }
        }
    }
}

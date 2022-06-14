//
//  HomeAPIManager.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import Foundation
import Combine
import CSV

class HomeAPIManager {
    static let shared = HomeAPIManager()
    func getStock() -> AnyPublisher<Result<StockList?, Error>, Never> {
        APIManager.sharedInstance.sendJSONRequest(url: "https://raw.githubusercontent.com/dsancov/TestData/main/stocks.csv")
            .map {
                String(decoding: $0, as: UTF8.self)
            }.map {
                var stock = [Stock]()
                do {
                    let reader = try CSVReader(string: $0, hasHeaderRow: true)
                    let decoder = CSVRowDecoder()
                    while reader.next() != nil {
                        let row = try decoder.decode(Stock.self, from: reader)
                        stock.append(row)
                    }
                    return .success(StockList(stocks: stock))
                } catch {
                    // Invalid row format
                    return .failure(CustomError.jsonSerializeError)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getNew() -> AnyPublisher<Result<News?, Error>, Never> {
        APIManager.sharedInstance.sendJSONRequest(url: "https://saurav.tech/NewsAPI/everything/cnn.json").map {
            if let news = News.from(data: $0) {
                return .success(news)
            } else {
                return .failure(CustomError.jsonSerializeError)
            }
        }.eraseToAnyPublisher()
    }
}

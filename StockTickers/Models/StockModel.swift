//
//  StockModel.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import Foundation
// MARK: - Stock
struct Stock: Codable {
    var stock: String?
    var price: String?
    
    enum CodingKeys: String, CodingKey {
        case stock = "STOCK"
        case price = " \"PRICE\""
    }
}
// MARK: - StockList
struct StockList: Codable {
    var stocks: [Stock]?
}

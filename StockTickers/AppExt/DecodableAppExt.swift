//
//  DecodableAppExt.swift
//  StockTickers
//
//  Created by MgKaung on 14/06/2022.
//

import Foundation
extension Decodable {
  static func from(json: String?, using encoding: String.Encoding = .utf8) -> Self? {
    guard let data = json?.data(using: encoding) else { return nil }
    return from(data: data)
  }
  
  static func from(data: Data?) -> Self? {
    let decoder = JSONDecoder()
    guard let jsonData = data else { return nil }
      decoder.dateDecodingStrategy = .formatted(DateFormatter.UTC) // 2022-05-05T09:33:40Z
    do {
      return try decoder.decode(Self.self, from: jsonData)
    } catch let error {
      print("Decodable \(#function) \(error)")
      return nil
    }
  }
}

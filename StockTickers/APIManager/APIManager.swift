//
//  APIManager.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import Foundation
import Combine
class APIManager {
    static let sharedInstance = APIManager()
    
    func sendJSONRequest(url: String) -> AnyPublisher<Data, Never> {
        guard let url = URL(string: url) else {
            return Just(Data()).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                return data
            }
            .replaceError(with: Data())
            .share()
            .eraseToAnyPublisher()
    }
}
public enum CustomError: Equatable, Error {
    case errorString(String)
    case connectionError
    case jsonSerializeError
    case csvSerializeError
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case.errorString(let errorStr):
            return NSLocalizedString(errorStr, comment: "custom error")
        case .connectionError:
            return "Please Check Your Internet Connection"
        case .jsonSerializeError:
            return "Json Serialize Error"
        case .csvSerializeError:
            return "CSV Serialize Error"
        }
    }
}

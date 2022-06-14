//
//  HomeVM.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import Foundation
import Combine

class HomeVM {
    private var cancellables: [AnyCancellable] = []
    @Published private(set) var headLineArticles: [Article]? = []
    @Published private(set) var articles: [Article]? = []
    @Published private(set) var stocks: [Stock]? = []
    @Published private(set) var isLoading: Bool = false
    init() {
        
    }
    
    func getAllData() {
        isLoading.toggle()
        Publishers
            .Zip(HomeAPIManager.shared.getStock(), HomeAPIManager.shared.getNew())
            .sink(receiveValue: { [weak self] (stockResult, newsResult)  in
                switch stockResult {
                case .success(let stocks):
                    let uniqueStock = (stocks?.stocks ?? [])
                        .shuffled()
                        .unique(map: {
                        $0.stock
                    })
                    self?.stocks = uniqueStock.sorted(by: { $0.stock ?? "" < $1.stock ?? "" })
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                switch newsResult {
                case .success(let news):
                    self?.headLineArticles = news?.articles?.limit(6) ?? []
                    self?.articles = Array(news?.articles?.dropFirst(6) ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.isLoading.toggle()
            })
            .store(in: &cancellables)
    }
    
    func getStock() {
        HomeAPIManager.shared.getStock()
            .sink(receiveValue: {[weak self] result in
                switch result {
                case .success(let stocks):
                    let uniqueStock = (stocks?.stocks ?? [])
                        .shuffled()
                        .unique(map: {
                        $0.stock
                    })
                    self?.stocks = uniqueStock.sorted(by: { $0.stock ?? "" < $1.stock ?? "" })
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            .store(in: &cancellables)
    }
}

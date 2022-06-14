//
//  StockCell.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import Foundation
import UIKit
class StockCell: UICollectionViewCell {
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    
    var stock: Stock? {
        didSet {
            stockName.text = stock?.stock
            stockPrice.text = "\(String(format: "%.2f", Double(stock?.price?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "0.0") ?? 0.0)) USD"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor =  UIColor(red: 249, green: 249, blue: 249, alpha: 1)
        shadowRoundCornerView()
    }
}
